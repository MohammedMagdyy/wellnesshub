class Exercise {
  final int id;
  final String exerciseName;
  final String description;
  final String targetMuscle;
  final String regionMuscle;
  final String imageUrl;
  final String difficulty;
  final String equipmentType;
  final String videoUrl;
  final String sets;
  final int? exerciseOrder;
  bool? exerciseDone;

  Exercise({
    required this.id,
    required this.exerciseName,
    required this.description,
    required this.targetMuscle,
    required this.regionMuscle,
    required this.imageUrl,
    required this.videoUrl,
    required this.sets,
    required this.difficulty,
    required this.equipmentType,
    this.exerciseOrder,
    this.exerciseDone,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    try {
      return Exercise(
        id: json['id'] as int? ?? 0,
        exerciseName: (json['name'] ?? json['exerciseName'] ?? 'Unknown') as String,
        description: (json['description'] ?? '') as String,
        targetMuscle: (json['targetMuscle'] ?? '') as String,
        regionMuscle: (json['regionMuscle'] ?? '') as String,
        // Added this line
        imageUrl: (json['imageUrl'] ?? json['image_url'] ?? '') as String,
        videoUrl: json['videoUrl'] as String,
        // Removed null check (required field)
        sets: json['sets'] as String,
        // Removed null check (required field)
        difficulty: json['difficulty'] as String,
        // Removed null check (required field)
        equipmentType: json['equipmentType'] ??
            json['equipment_type'] as String,
        // Combined variants
        exerciseOrder: json['exerciseOrder'] as int?,
        exerciseDone: json['exerciseDone'] as bool?,
      );
    } catch (e, stackTrace) {
      print('Error parsing Exercise: $e');
      print('Stack trace: $stackTrace');
      print('Problematic JSON: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': exerciseName,
        'description': description,
        'targetMuscle': targetMuscle,
        'regioNMuscle': regionMuscle,
        // Added this missing field
        'imageUrl': imageUrl,
        // Changed to match constructor's required field
        'videoUrl': videoUrl,
        // Changed to match constructor's required field
        'sets': sets,
        // Changed to match constructor's required field
        'difficulty': difficulty,
        // Changed to match constructor's required field
        'equipmentType': equipmentType,
        // Changed to match constructor's required field
        if (exerciseOrder != null) 'exerciseOrder': exerciseOrder,
        if (exerciseDone != null) 'exerciseDone': exerciseDone,
      };


}