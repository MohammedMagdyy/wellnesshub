class Exercise {
  int id;
  String exerciseName;
  String description;
  String targetMuscle;
  int exerciseOrder;
  bool exerciseDone;
  String sets;
  String imageUrl;
  String videoUrl;

  Exercise({
    required this.id,
    required this.exerciseName,
    required this.description,
    required this.targetMuscle,
    required this.exerciseOrder,
    required this.exerciseDone,
    required this.sets,
    required this.imageUrl,
    required this.videoUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    exerciseName: json["exerciseName"],
    description: json["description"],
    targetMuscle: json["targetMuscle"],
    exerciseOrder: json["exerciseOrder"],
    exerciseDone: json["exerciseDone"],
    sets: json["sets"],
    imageUrl: json["imageUrl"],
    videoUrl: json["videoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exerciseName": exerciseName,
    "description": description,
    "targetMuscle": targetMuscle,
    "exerciseOrder": exerciseOrder,
    "exerciseDone": exerciseDone,
    "sets": sets,
    "imageUrl": imageUrl,
    "videoUrl": videoUrl,
  };
}