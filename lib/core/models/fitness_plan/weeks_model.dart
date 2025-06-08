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


// class Week {
//   int id;
//   int weekNumber;
//   List<Day> days;
//
//   Week({
//     required this.id,
//     required this.weekNumber,
//     required this.days,
//   });
//
//   factory Week.fromJson(Map<String, dynamic> json) => Week(
//     id: json["id"],
//     weekNumber: json["weekNumber"],
//     days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
//   );
//
// }