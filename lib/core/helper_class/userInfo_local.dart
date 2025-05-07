import 'package:shared_preferences/shared_preferences.dart';

class UserInfoLocalStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Save user account information
  Future<void> saveUserData({
    required String email,
    required String fname,
    required String lname,
    required String password,
  }) async {
    final prefs = await _prefs;
    await prefs.setString('email', email);
    await prefs.setString('fname', fname);
    await prefs.setString('lname', lname);
    await prefs.setString('password', password);
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await _prefs;
    return {
      'email': prefs.getString('email'),
      'fname': prefs.getString('fname'),
      'lname': prefs.getString('lname'),
      'password': prefs.getString('password'),
    };
  }

  /// Save & Get Height
  Future<void> saveUserHeight(int height) async {
    final prefs = await _prefs;
    await prefs.setInt('height', height);
  }

  Future<int?> getUserHeight() async {
    final prefs = await _prefs;
    return prefs.getInt('height');
  }

  /// Save & Get Weight
  Future<void> saveUserWeight(int weight) async {
    final prefs = await _prefs;
    await prefs.setInt('weight', weight);
  }

  Future<int?> getUserWeight() async {
    final prefs = await _prefs;
    return prefs.getInt('weight');
  }

  /// Save & Get Age
  Future<void> saveUserAge(int age) async {
    final prefs = await _prefs;
    await prefs.setInt('age', age);
  }

  Future<int?> getUserAge() async {
    final prefs = await _prefs;
    return prefs.getInt('age');
  }

  /// Save & Get Gender
  Future<void> saveUserGender(String gender) async {
    final prefs = await _prefs;
    await prefs.setString('gender', gender);
  }

  Future<String?> getUserGender() async {
    final prefs = await _prefs;
    return prefs.getString('gender');
  }

  /// Save & Get Activity Level
  Future<void> saveUserActivityLevel(String activityLevel) async {
    final prefs = await _prefs;
    await prefs.setString('activityLevel', activityLevel);
  }

  Future<String?> getUserActivityLevel() async {
    final prefs = await _prefs;
    return prefs.getString('activityLevel');
  }

  /// Save & Get Injury Info
  Future<void> saveUserInjury(String injury) async {
    final prefs = await _prefs;
    await prefs.setString('injury', injury);
  }

  Future<String?> getUserInjury() async {
    final prefs = await _prefs;
    return prefs.getString('injury');
  }

  /// Save & Get Goal
  Future<void> saveUserGoal(String goal) async {
    final prefs = await _prefs;
    await prefs.setString('goal', goal);
  }

  Future<String?> getUserGoal() async {
    final prefs = await _prefs;
    return prefs.getString('goal');
  }

  /// Save & Get Experience Level
  Future<void> saveUserExperienceLevel(String experienceLevel) async {
    final prefs = await _prefs;
    await prefs.setString('experienceLevel', experienceLevel);
  }

  Future<String?> getUserExperienceLevel() async {
    final prefs = await _prefs;
    return prefs.getString('experienceLevel');
  }

  /// Save & Get Workout Days
  Future<void> saveUserWorkoutDays(String workoutDays) async {
    final prefs = await _prefs;
    await prefs.setString('workoutDays', workoutDays);
  }

  Future<String?> getUserWorkoutDays() async {
    final prefs = await _prefs;
    return prefs.getString('workoutDays');
  }

  /// Save & Get OTP
  Future<void> saveUserOtp(String otp) async {
    final prefs = await _prefs;
    await prefs.setString('otp', otp);
  }

  Future<String?> getUserOtp() async {
    final prefs = await _prefs;
    return prefs.getString('otp');
  }

  /// Clear all stored user data (for delete account or logout)
  Future<void> clearAllUserData() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

}
