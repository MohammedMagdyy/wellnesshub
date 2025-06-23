import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/ExerciseCard.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../core/helper_class/favourite_manager.dart';
import '../core/helper_functions/simplify_errormessage.dart';
import '../core/models/fitness_plan/exercises_model.dart';
import '../core/services/exercises/specificexercise_service.dart';
import '../core/widgets/error_widget.dart';
import '../core/widgets/server_error_widget.dart';

class SpecificExercisePage extends StatefulWidget {
  const SpecificExercisePage({super.key, required this.title});
  static const routeName = 'SpecificExercisePage';
  final String title;

  @override
  State<SpecificExercisePage> createState() => _SpecificExercisePageState();
}

class _SpecificExercisePageState extends State<SpecificExercisePage> {
  late Future<List<Exercise>> _exercisesFuture;

  String _formatRegionMuscle(String title) {
    // Map uppercase/lowercase inputs to backend-expected values
    switch (title) {
      case 'SHOULDER': return 'Shoulder';
      case 'ARM': return 'Arm';
      case 'CHEST': return 'Chest';
      case 'BACK': return 'Back';
      case 'LEG': return 'Leg';
      case 'RECOVERY': return 'Recovery';
      case 'CARDIO': return 'Cardio';
      case 'STRETCHES': return 'Stretches';
      case 'YOGA': return 'Yoga';

      default: return title; // Fallback
    }
  }

// Usage:


  Future<void> _retryFetch() async {
    setState(() {
      final formattedTitle = _formatRegionMuscle(widget.title);
      _exercisesFuture = SpecificExerciseService().fetchExercises
        (formattedTitle);
    });
  }

  @override
  void initState() {
    super.initState();
    final formattedTitle = _formatRegionMuscle(widget.title);
    _exercisesFuture = SpecificExerciseService().fetchExercises
      (formattedTitle);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(title:""),
      backgroundColor: isDark? darkBackgroundColor : lightBackgroundColor,
      body: SafeArea(
        child: FutureBuilder<List<Exercise>>(
          future: _exercisesFuture,
          builder: (context, snapshot) {
            // Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(isDark? darkBackgroundColor : lightBackgroundColor),
                ),
              );
            }

            // Error States
            else if (snapshot.hasError) {
              final errorString = snapshot.error.toString().toLowerCase();

              if (errorString.contains('session timeout')) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Session Expired"),
                        content: const Text("Your session has timed out. Please log in again."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                "LoginPage", // or whatever your login route is
                                    (route) => false,
                              );
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                });

                return const SizedBox(); // Return empty widget after dialog is scheduled
              }

              if (errorString.contains('server')) {
                return ServerErrorWidget(onRetry: _retryFetch);
              }

              return ErrorDisplayWidget(
                errorMessage: simplifyErrorMessage(snapshot.error.toString()),
                onRetry: _retryFetch,
              );
            }


            // Empty State
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return ErrorDisplayWidget(
                errorMessage: 'No exercises found for ${widget.title}',
                onRetry: _retryFetch,
                icon: Icons.search_off,
                color: Colors.orange,
              );
            }

            // Success State - Display list of exercises
            final exercises = snapshot.data!;
            return CustomScrollView(
              slivers: [
                 SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: 80.0,
                  backgroundColor: isDark? darkBackgroundColor : lightBackgroundColor,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                    title: Text(
                      '${widget.title} Exercises',
                      style: TextStyle(
                        color: isDark? darkBmiTextColor_1 : lightBmiTextColor_1,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final exercise = exercises[index];
                      final isFav = FavoriteManager.instance.isFavorite(exercise.id);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ExerciseCard(
                          isFav: false,
                          exercise: exercise,
                          isFavorite: isFav,
                          onFavoriteToggle: () async {
                            if (isFav) {
                              await FavoriteManager.instance.removeFavorite(exercise);
                            } else {
                              await FavoriteManager.instance.addFavorite(exercise);
                            }
                          },
                        ),
                      );
                    },
                    childCount: exercises.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}