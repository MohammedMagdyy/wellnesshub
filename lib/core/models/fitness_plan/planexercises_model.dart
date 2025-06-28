import 'package:wellnesshub/core/models/fitness_plan/weeks_model.dart';

class ExercisePlan {
  final int id;
  final int daysPerWeek;
  final List<Week> weeks;

  ExercisePlan({
    required this.id,
    required this.daysPerWeek,
    required this.weeks,
  });

  factory ExercisePlan.fromJson(Map<String, dynamic> json) {
    return ExercisePlan(
      id: json['id'], // Ensure string conversion
      daysPerWeek: json['daysPerWeek'] as int,
      weeks: (json['weeks'] as List)
          .map((week) => Week.fromJson(week))
          .toList(),
    );
  }
}









