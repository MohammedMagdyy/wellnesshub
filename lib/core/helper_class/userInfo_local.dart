import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sign_up/full_userinfo_model.dart';
import '../models/sign_up/userinfo_model.dart';

class UserInfoLocalStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Save user account information
  Future<void> saveUserEmail({required String email,}) async {
    final prefs = await _prefs;
    await prefs.setString('email', email);
  }
  Future<String?> getUserEmail() async {
    final prefs = await _prefs;
    return prefs.getString('email');
  }
  Future<void> saveUserData({
   // required String email,
    required String fname,
    required String lname,
    required String password,

  }) async {
    final prefs = await _prefs;
    //await prefs.setString('email', email);
    await prefs.setString('fname', fname);
    await prefs.setString('lname', lname);
    await prefs.setString('password', password);
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await _prefs;
    return {
      //'email': prefs.getString('email'),
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
  Future<void> saveUserWorkoutDays(int workoutDays) async {
    final prefs = await _prefs;
    await prefs.setInt('workoutDays', workoutDays);
  }

  Future<int?> getUserWorkoutDays() async {
    final prefs = await _prefs;
    return prefs.getInt('workoutDays');
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

  Future<UserInfo> getUserInfoModel() async {
    final prefs = await _prefs;

    return UserInfo(
      gender: prefs.getString('gender') !, // Provide default if null
      age: prefs.getInt('age') !,          // Provide default if null
      weight: prefs.getInt('weight')! ,     // Provide default if null
      height: prefs.getInt('height') !,     // Provide default if null
      goal: prefs.getString('goal') !,     // Provide default if null
      activityLevel: prefs.getString('activityLevel') !,
      experienceLevel: prefs.getString('experienceLevel') !,
      daysPerWeek: prefs.getInt('workoutDays')!,

    );
  }

    static const String _key = 'user_info';

    /// Save FullUserInfo to local storage
  static Future<void> saveUserInfoForProfile(FullUserInfo userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(userInfo.toJson());
    await prefs.setString(_key, userJson);
  }

  /// Retrieve FullUserInfo from local storage with safe error handling
  static Future<FullUserInfo?> getUserInfoForProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_key);
      if (userJson != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(userJson);
        return FullUserInfo.fromJson(jsonMap);
      }
    } catch (e) {
      // Log error or ignore corrupted data silently
      print('Error reading user info from local storage: $e');
    }
    return null;
  }


  /// Clear user info (e.g., on logout)
    static Future<void> clearUserInfoForProfile() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    }

}
