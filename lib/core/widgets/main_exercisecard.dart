import 'package:flutter/material.dart';
import 'package:wellnesshub/core/models/fitness_plan/exercises_model.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class MainExerciseCardFitnessPlan extends StatefulWidget {
  final Exercise exercise;
  final int weekId;
  final int dayId;

  const MainExerciseCardFitnessPlan({
    super.key,
    required this.exercise,
    required this.weekId,
    required this.dayId,
  });

  @override
  State<MainExerciseCardFitnessPlan> createState() => _MainExerciseCardFitnessPlanState();
}

class _MainExerciseCardFitnessPlanState extends State<MainExerciseCardFitnessPlan> {
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

        // onTap: () {
        //   Navigator.pushNamed(
        //     context,
        //     'ExercisePageDetails',
        //     arguments:{
        //       'exercise': widget.exercise,
        //       'weekId': widget.weekId,
        //       'dayId': widget.dayId,
        //     },
        //   );
        // },
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
                        widget.exercise.sets!,
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
                if (widget.exercise.exerciseDone! ?? true)
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Image.asset(
                      Assets.assetsImagesDone,
                      width: 44, // Adjust size as needed
                      height: 54,
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