import 'package:flutter/material.dart';
import 'package:wellnesshub/core/models/fitness_plan/exercises_model.dart';


class ExerciseCard extends StatelessWidget {
  final Exercise exercise;


  const ExerciseCard({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:6),
      child:InkWell(
        borderRadius: BorderRadius.circular(16), // Match the borderRadius from the original example
        onTap: () {
          Navigator.pushNamed(
            context,
            'ExercisePageDetails',
            arguments: exercise, // Pass the exercise object
          );
        },
        child: SizedBox(
          height: 190, // Adjust to match your original card's height
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
                      exercise.imageUrl,
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
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          exercise.exerciseName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Adjust the font size to match the design
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          exercise.difficulty!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Target: ${exercise.targetMuscle}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
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