import 'exercises_model.dart';

class Day {
  int id;
  int dayNumber;
  List<Exercise> exercises;

  Day({
    required this.id,
    required this.dayNumber,
    required this.exercises,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    id: json["id"],
    dayNumber: json["dayNumber"],
    exercises:
    List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayNumber": dayNumber,
    "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
  };
}