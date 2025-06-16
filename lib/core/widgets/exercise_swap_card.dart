import 'package:flutter/material.dart';
import 'package:wellnesshub/core/models/fitness_plan/exercises_model.dart';
import 'package:wellnesshub/core/services/workout_plan/swap_services.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../helper_functions/build_customSnackbar.dart';

class ExerciseSwapCard extends StatefulWidget {
  final Exercise exercise;
  final int oldExerciseID;
  final int weekId;
  final int dayId;

  const ExerciseSwapCard({
    super.key,
    required this.exercise,
    required this.oldExerciseID,
    required this.weekId,
    required this.dayId,
  });

  @override
  State<ExerciseSwapCard> createState() => _ExerciseSwapCardState();
}

class _ExerciseSwapCardState extends State<ExerciseSwapCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {

          final result =await SwapService.setSwap(
              widget.dayId,widget.weekId,
            widget.oldExerciseID,widget.exercise.id,
          );
          if (result['message'] == "Exercise swapped successfully!") {
            ScaffoldMessenger.of(context).showSnackBar(
              buildCustomSnackbar(
                title: "",
                message: "Exercise Swapped Successfully!",
                type: ContentType.success,
                backgroundColor: Colors.green,
              ),
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              buildCustomSnackbar(
                title: "Error",
                message: result['message'],
                type: ContentType.failure,
                backgroundColor: Colors.red
              ),
            );
          }
            Navigator.pop(context,true);


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
                    child: widget.exercise.imageUrl != null
                        ? Image.network(
                      widget.exercise.imageUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(
                        Icons.broken_image,
                        size: 48,
                      ),
                    )
                        : Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.white,
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
                        widget.exercise.sets ?? 'No sets info',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Target: ${widget.exercise.targetMuscle ?? 'Unknown'}",
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
                      width: 44,
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
