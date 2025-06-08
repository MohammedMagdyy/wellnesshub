import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/ExerciseCard.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../core/helper_functions/simplify_errormessage.dart';
import '../core/models/fitness_plan/exercises_model.dart';
import '../core/services/exercises/specificexercise_service.dart';
import '../core/widgets/error_widget.dart';
import '../core/widgets/server_error_widget.dart';
import '../core/widgets/main_exercisecard.dart';

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
      case 'CARDIO': return 'Cardio';
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
    return Scaffold(
      appBar: CustomAppbar(title:""),
      backgroundColor: const Color(0xFF7F9CF5),
      body: SafeArea(
        child: FutureBuilder<List<Exercise>>(
          future: _exercisesFuture,
          builder: (context, snapshot) {
            // Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7F9CF5)),
                ),
              );
            }

            // Error States
            if (snapshot.hasError) {
              if (snapshot.error.toString().contains('server')) {
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
                  backgroundColor: Color(0xFF7F9CF5),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                    title: Text(
                      '${widget.title} Exercises',
                      style: TextStyle(
                        color: Colors.amberAccent,
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ExerciseCard(exercise: exercise)
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