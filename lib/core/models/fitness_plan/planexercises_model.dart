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


// class ExercisePlan {
//   int id;
//   int daysPerWeek;
//   List<Week> weeks;
//
//   ExercisePlan({
//     required this.id,
//     required this.daysPerWeek,
//     required this.weeks,
//   });
//
//   factory ExercisePlan.fromJson(Map<String, dynamic> json) => ExercisePlan(
//     id: json["id"],
//     daysPerWeek: json["daysPerWeek"],
//     weeks: List<Week>.from(json["weeks"].map((x) => Week.fromJson(x))),
//   );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "weeks": List<dynamic>.from(weeks.map((x) => x.toJson())),
  // };







