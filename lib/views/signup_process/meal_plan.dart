import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/meal_plan_section.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../../core/helper_class/accesstoken_storage.dart';
import '../../core/helper_functions/build_customSnackbar.dart';
import '../../core/models/sign_up/userinfo_model.dart';
import '../../core/services/auth/login_service.dart';
import '../../core/services/auth/signup_service.dart';
import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class MealPlan extends StatefulWidget {
  const MealPlan({super.key});
  static const routeName = 'MealPlan';

  @override
  _MealPlanState createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  String? selectedDietaryPreference;
  String? selectedAllergy;
  String? selectedMealType;
  String? selectedCaloricGoal;
  String? selectedCookingTime;
  String? selectedServings;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppbar(title: ""),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MealPlanSection(
                title: "Dietary Preferences",
                options: [
                  "Vegetarian", "Vegan", "Gluten-Free", "Keto", "Paleo", "No preferences"
                ],
                selectedValue: selectedDietaryPreference,
                onChanged: (value) {
                  if (!mounted) return;
                  setState(() => selectedDietaryPreference = value);
                },
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                )
                    : CustomButton(
                  width: width * 0.6,
                  color: Colors.black,
                  name: 'Submit',
                  on_Pressed: () async {
                    if (!mounted) return;
                    setState(() => _isLoading = true);

                    try {
                      final userinfo = await storage.getUserData();
                      if (userinfo['email'] == null || userinfo['password'] == null) {
                        throw Exception('User credentials not found in local storage');
                      }

                      final signupService = SignupService();
                      final signupResult = await signupService.signup(
                        userinfo['fname']!,
                        userinfo['lname']!,
                        userinfo['email']!,
                        userinfo['password']!,
                      );

                      if (signupResult['success'] == true) {
                        print("@@@@@@@@@@@OK@@@@@@@@@@@@@@@@@@@");
                      } else {
                        // Show error message to user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(signupResult['message'] ?? 'Signup failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }



                      final loginResult = await LoginService().login(
                        userinfo['email']!,
                        userinfo['password']!,
                      );

                      if (!loginResult['success']) {
                        throw Exception(loginResult['message'] ?? 'Login failed');
                      }

                      final token = await LocalStorageAccessToken.getToken();
                      print('Token: $token');

                      final userInfo = await storage.getUserInfoModel();
                      final updatedUserInfo = UserInfo(
                        gender: userInfo.gender ?? 'MALE',
                        age: userInfo.age ?? 25,
                        weight: userInfo.weight ?? 70,
                        height: userInfo.height ?? 170,
                        goal: userInfo.goal ?? 'WEIGHT_CUT',
                        activityLevel: userInfo.activityLevel ?? 'Sedentary',
                        experienceLevel: userInfo.experienceLevel ?? 'BEGINNER',
                        daysPerWeek: userInfo.daysPerWeek ?? 3,
                      );

                      final userInfoResult = await signupService.saveUserInfo(
                        userinfo['email']!,
                        updatedUserInfo,
                      );

                      print('SaveUserInfo response: $userInfoResult');

                      if (userInfoResult['success'] == true) {
                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'MainPage',
                              (Route<dynamic> route) => false,
                        );
                      } else {
                        throw Exception(userInfoResult['message'] ??
                            'Failed to save user info. Status code: ${userInfoResult['statusCode']}');
                      }
                    } catch (e, stackTrace) {
                      print('Error details: $e\n$stackTrace');
                      if (!mounted) return;
                      final snackBar = buildCustomSnackbar(
                        backgroundColor: Colors.redAccent,
                        title: 'Error!',
                        message: e.toString(),
                        type: ContentType.failure,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } finally {
                      if (!mounted) return;
                      setState(() => _isLoading = false);
                    }
                  },
                ),
              ),
              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
