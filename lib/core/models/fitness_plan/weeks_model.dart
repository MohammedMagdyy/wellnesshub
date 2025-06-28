import 'days_model.dart';

class Week {
  final int id;
  final int weekNumber;
  final List<Day> days;

  Week({
    required this.id,
    required this.weekNumber,
    required this.days,
  });

  factory Week.fromJson(Map<String, dynamic> json) {
    return Week(
      id: json['id'],
      weekNumber: json['weekNumber'] as int,
      days: (json['days'] as List)
          .map((day) => Day.fromJson(day))
          .toList(),
    );
  }
}
