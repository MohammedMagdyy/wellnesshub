import 'package:flutter/material.dart';
import 'package:wellnesshub/core/models/fitness_plan/exercises_model.dart';
import 'package:wellnesshub/core/services/workout_plan/swap_services.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/views/fitnessplanpage.dart';
import 'exercise_swap_card.dart';

class MainExerciseCardFitnessPlan extends StatefulWidget {
  final Exercise exercise;
  final int weekId;
  final int dayId;
  final VoidCallback onSwapSuccess;

  const MainExerciseCardFitnessPlan({
    super.key,
    required this.exercise,
    required this.weekId,
    required this.dayId,
    required this.onSwapSuccess,
  });


  @override
  State<MainExerciseCardFitnessPlan> createState() => _MainExerciseCardFitnessPlanState();
}

class _MainExerciseCardFitnessPlanState extends State<MainExerciseCardFitnessPlan> {


  Future<bool?> showExerciseDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exercises'),
          content: SizedBox(
            width: double.maxFinite,
            child: FutureBuilder<List<Exercise>>(
              future: fetchOldSwappedExercise(widget.exercise.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No exercises found.');
                }

                final exercises = snapshot.data!;
                return ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return ExerciseSwapCard(
                      oldExerciseID: widget.exercise.id,
                      exercise: exercise,
                      weekId: widget.weekId,
                      dayId: widget.dayId,
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
    return result;

  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          final result = await Navigator.pushNamed(
            context,
            'ExercisePageDetails',
            arguments: {
              'exercise': widget.exercise,
              'weekId': widget.weekId,
              'dayId': widget.dayId,
              'plan': true,
              'isFav': false,
            },
          );

          if (result == true) {
            setState(() {
              // widget.exercise.exerciseDone = true;
            });
          }
        },

        child: SizedBox(
          height: 190,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                    child: Image.network(
                      widget.exercise.imageUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 48,
                      ),
                    ),
                  ),
                ),
                // Content (Text)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.exercise.exerciseName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.exercise.sets?? 'No sets',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Target: ${widget.exercise.targetMuscle}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // Done icon (positioned at the end)
                if (widget.exercise.exerciseDone ?? false)
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Image.asset(
                      Assets.assetsImagesDone,
                      width: 44, // Adjust size as needed
                      height: 54,
                    ),
                  ),

                Positioned(
                  right:8,
                  top: 120,
                  child: IconButton(
                    icon: const Icon(
                      Icons.swap_horizontal_circle_rounded,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onPressed: ()async{
                      final swapped = await showExerciseDialog(context);
                      if (swapped == true) {
                        // Reload the data
                        if (mounted) {
                          widget.onSwapSuccess(); // Triggers rebuild to reflect updated exercise
                        }
                      }
                    },

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Future<List<Exercise>> fetchOldSwappedExercise(int exerciseId) async {
  final response = await SwapService.swapExercise(exerciseId);
  return response;
}
