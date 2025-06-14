import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../core/models/fitness_plan/exercises_model.dart';
import '../core/widgets/exercise_details.dart';

class ExercisePageDetails extends StatelessWidget {
  static const routeName = 'ExercisePageDetails';
  final Exercise exercise;
  final bool plan;
  final bool isFav;
  final int? weekId;
  final int? dayId;
  //final bool isFromFitnessPlan;

  const ExercisePageDetails({
    super.key,
    required this.exercise,
    required this.isFav,
    required this.plan,
    this.weekId,
    this.dayId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(title: "Exercise"),
        body:ExerciseDetails(
          exercise: exercise,
          plan: plan,
          isFav: isFav,
          dayId: dayId,
          weekId: weekId,
        ),
      ),
    );
  }
}
