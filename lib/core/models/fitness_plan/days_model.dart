import 'exercises_model.dart';


class Day {
  final int id;
  final int dayNumber;
  final List<Exercise> exercises;

  Day({
    required this.id,
    required this.dayNumber,
    required this.exercises,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'], // Ensure string conversion
      dayNumber: json['dayNumber'] as int,
      exercises: (json['exercises'] as List)
          .map((exercise) => Exercise.fromJson(exercise))
          .toList(),
    );
  }
}
