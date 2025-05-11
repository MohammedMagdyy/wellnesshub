class FavoriteExercisePlan {
  int id;
  String name;
  String description;
  String targetMuscle;
  String difficulty;
  String equipmentType;
  String imageUrl;
  String maleVideoUrl;
  String femaleVideoUrl;
  int similarGroupId;

  FavoriteExercisePlan({
    required this.id,
    required this.name,
    required this.description,
    required this.targetMuscle,
    required this.difficulty,
    required this.equipmentType,
    required this.imageUrl,
    required this.maleVideoUrl,
    required this.femaleVideoUrl,
    required this.similarGroupId,
  });

  factory FavoriteExercisePlan.fromJson(Map<String, dynamic> json) => FavoriteExercisePlan(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    targetMuscle: json["targetMuscle"],
    difficulty: json["difficulty"],
    equipmentType: json["equipment_type"],
    imageUrl: json["image_url"],
    maleVideoUrl: json["maleVideoUrl"],
    femaleVideoUrl: json["femaleVideoUrl"],
    similarGroupId: json["similarGroupId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "targetMuscle": targetMuscle,
    "difficulty": difficulty,
    "equipment_type": equipmentType,
    "image_url": imageUrl,
    "maleVideoUrl": maleVideoUrl,
    "femaleVideoUrl": femaleVideoUrl,
    "similarGroupId": similarGroupId,
  };
}