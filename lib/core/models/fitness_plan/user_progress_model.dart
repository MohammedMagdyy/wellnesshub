class GetUserProgress {
  final int dayNumber;
  final int totalExercises;
  final int completedExercises;

  GetUserProgress({
    required this.dayNumber,
    required this.totalExercises,
    required this.completedExercises,
  });


  factory GetUserProgress.fromJson(Map<String, dynamic> json) {
    return GetUserProgress(
      dayNumber: json['dayNumber'],
      totalExercises: json['totalExercises'],
      completedExercises: json['completedExercises'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'totalExercises': totalExercises,
      'completedExercises': completedExercises,
    };
  }
}