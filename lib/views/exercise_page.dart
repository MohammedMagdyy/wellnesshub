import 'package:flutter/material.dart';
import 'package:wellnesshub/core/services/workout_plan/workoutplan_service.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/videos.dart';

import '../core/models/fitness_plan/exercises_model.dart';
import '../core/widgets/exercise_details.dart';
import '../core/widgets/video_widget.dart';

// class ExercisePage extends StatefulWidget {
//   const ExercisePage({super.key});
//   static const routeName = 'ExercisePage';
//
//   @override
//   State<ExercisePage> createState() => _ExercisePageState();
// }
//
// class _ExercisePageState extends State<ExercisePage> {
//   Future<Exercise?>? _exerciseFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _exerciseFuture = _loadFirstExercise();
//   }
//
//   Future<Exercise?> _loadFirstExercise() async {
//     final plan = await WorkoutPlanService().fetchUserPlan();
//     if (plan.weeks.isNotEmpty &&
//         plan.weeks[0].days.isNotEmpty &&
//         plan.weeks[0].days[0].exercises.isNotEmpty) {
//       return plan.weeks[0].days[0].exercises[0];
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: CustomAppbar(title: "Exercise"),
//         body: FutureBuilder<Exercise?>(
//           future: _exerciseFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData) {
//               return const Center(child: Text('No exercise found.'));
//             }
//
//             final exercise = snapshot.data!;
//             return ExerciseDetails(exercise: exercise);
//           },
//         ),
//       ),
//     );
//   }
// }
//
class ExercisePage extends StatelessWidget {
  static const routeName = 'ExercisePage';
  final Exercise exercise;
  const ExercisePage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(title: "Exercise"),
        body: ExerciseDetails(exercise: exercise),
      ),
    );
  }
}