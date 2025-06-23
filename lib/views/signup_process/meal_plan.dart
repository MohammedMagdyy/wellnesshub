import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/meal_plan_section.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../../core/helper_class/accesstoken_storage.dart';
import '../../core/helper_functions/build_customSnackbar.dart';
import '../../core/models/sign_up/userinfo_model.dart';
import '../../core/services/auth/facebook_login.dart';
import '../../core/services/auth/google_login.dart';
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
                      final signupService = SignupService();

                      try {
                        final userinfoEmail = await storage.getUserEmail();
                        final userinfo = await storage.getUserData();

                        final userInfo = await storage.getUserInfoModel();

                        final updatedUserInfo = UserInfo(
                          gender: userInfo.gender,
                          age: userInfo.age,
                          weight: userInfo.weight,
                          height: userInfo.height,
                          goal: userInfo.goal,
                          activityLevel: userInfo.activityLevel,
                          experienceLevel: userInfo.experienceLevel,
                          daysPerWeek: userInfo.daysPerWeek,
                        );

                        final userInfoResult = await signupService.saveUserInfo(
                          userinfoEmail!,
                          updatedUserInfo,
                        );

                        debugPrint('✅ SaveUserInfo response: $userInfoResult');

                        if (userInfoResult['success'] != true) {
                          throw Exception(userInfoResult['message'] ??
                              'Failed to save user info. Status code: ${userInfoResult['statusCode']}');
                        }

                        /// ✅ Step 1: Login/Register first
                        bool loginSuccess = false;

                        if (googleFlag) {
                          final googleLogin = GoogleLoginService();
                          final result = await googleLogin.loginWithGoogle();
                          googleFlag = false;

                          loginSuccess = result['success'] == true;
                        } else if (facebookFlag) {
                          final facebookLogin = FacebookLoginService();
                          final result = await facebookLogin.loginWithFacebook();
                          facebookFlag = false;
                          loginSuccess = result['success'] == true;
                        } else {
                          final result = await LoginService().login(
                            userinfoEmail,
                            userinfo['password']!,
                          );
                          loginSuccess = result['success'] == true;
                        }

                        if (!loginSuccess) {
                          throw Exception('Login failed. Please try again.');
                        }

                        /// ✅ Step 2: Now save user info (email is now known to backend)


                        /// ✅ Final Step: Navigate
                        final token = await LocalStorageAccessToken.getToken();
                        debugPrint('✅ Access Token: $token');

                        googleFlag = false;
                        facebookFlag = false;

                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'MainPage',
                              (Route<dynamic> route) => false,
                        );
                      } catch (e, stackTrace) {
                        debugPrint('❌ Error: $e\n$stackTrace');
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
                    }




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
