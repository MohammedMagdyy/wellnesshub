import 'days_model.dart';

class Week {
  int id;
  int weekNumber;
  List<Day> days;

  Week({
    required this.id,
    required this.weekNumber,
    required this.days,
  });

  factory Week.fromJson(Map<String, dynamic> json) => Week(
    id: json["id"],
    weekNumber: json["weekNumber"],
    days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weekNumber": weekNumber,
    "days": List<dynamic>.from(days.map((x) => x.toJson())),
  };
}