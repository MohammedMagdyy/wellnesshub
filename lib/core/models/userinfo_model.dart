class UserInfo {
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String goal;
  final String activityLevel;
  final String experienceLevel;
  final int daysPerWeek;

  UserInfo({
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.goal,
    required this.activityLevel,
    required this.experienceLevel,
    required this.daysPerWeek,
  });

  Map<String, dynamic> toJson() {
    return {
      'gender': _formatGender(gender),
      'age': age,
      'weight': weight,
      'height': height,
      'goal': _formatGoal(goal),
      'activityLevel': _formatActivityLevel(activityLevel),
      'experienceLevel': _formatExperienceLevel(experienceLevel),
      'daysPerWeek': daysPerWeek,
    };
  }

  String _formatGender(String gender) {
    if (gender.isEmpty) return 'MALE'; // Default
    return gender.toUpperCase(); // Converts to "MALE" or "FEMALE"
  }

  String _formatGoal(String goal) {
    if (goal.isEmpty) return 'WEIGHT_CUT'; // Default
    // Map to backend enum values
    return goal
        .toUpperCase()
        .replaceAll(' ', '_'); // Converts "weight cut" to "WEIGHT_CUT"
  }

  String _formatActivityLevel(String level) {
    if (level.isEmpty) return 'Sedentary'; // Default
    // Match the exact string values expected by backend
    switch (level.toLowerCase()) {
      case 'sedentary':
        return 'Sedentary';
      case 'lightly active':
        return 'Lightly active';
      case 'moderately active':
        return 'Moderately active';
      case 'very active':
        return 'Very active';
      default:
        return 'Sedentary'; // Fallback
    }
  }

  String _formatExperienceLevel(String level) {
    if (level.isEmpty) return 'BEGINNER'; // Default
    return level.toUpperCase(); // Converts to "BEGINNER", "INTERMEDIATE", etc.
  }
}