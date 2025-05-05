import 'dart:convert';

import 'package:wellnesshub/core/models/weeks_model.dart';

class ExercisePlan {
  int id;
  int daysPerWeek;
  List<Week> weeks;

  ExercisePlan({
    required this.id,
    required this.daysPerWeek,
    required this.weeks,
  });

  factory ExercisePlan.fromJson(Map<String, dynamic> json) => ExercisePlan(
    id: json["id"],
    daysPerWeek: json["daysPerWeek"],
    weeks: List<Week>.from(json["weeks"].map((x) => Week.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weeks": List<dynamic>.from(weeks.map((x) => x.toJson())),
  };
}






