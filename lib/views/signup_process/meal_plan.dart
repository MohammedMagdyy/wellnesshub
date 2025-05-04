import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/meal_plan_section.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

import '../../core/helper_functions/build_customSnackbar.dart';
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
      appBar: CustomAppbar(
        title: "",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MealPlanSection(
                title: "Dietary Preferences",
                options: ["Vegetarian", "Vegan", "Gluten-Free", "Keto", "Paleo", "No preferences"],
                selectedValue: selectedDietaryPreference,
                onChanged: (value) => setState(() => selectedDietaryPreference = value),
              ),
              MealPlanSection(
                title: "Allergies",
                options: ["Nuts", "Dairy", "Shellfish", "Eggs", "No allergies"],
                selectedValue: selectedAllergy,
                onChanged: (value) => setState(() => selectedAllergy = value),
              ),
              MealPlanSection(
                title: "Meal Types",
                options: ["Breakfast", "Lunch", "Dinner", "Snacks"],
                selectedValue: selectedMealType,
                onChanged: (value) => setState(() => selectedMealType = value),
              ),
              MealPlanSection(
                title: "Caloric Goal",
                options: [
                  "Less than 1500 calories",
                  "1500-2000 calories",
                  "More than 2000 calories",
                  "Not sure/Don't have a goal"
                ],
                selectedValue: selectedCaloricGoal,
                onChanged: (value) => setState(() => selectedCaloricGoal = value),
              ),
              MealPlanSection(
                title: "Cooking Time",
                options: ["Less than 15 minutes", "15-30 minutes", "More than 30 minutes"],
                selectedValue: selectedCookingTime,
                onChanged: (value) => setState(() => selectedCookingTime = value),
              ),
              MealPlanSection(
                title: "Servings",
                options: ["1", "2", "3-4", "More than 4"],
                selectedValue: selectedServings,
                onChanged: (value) => setState(() => selectedServings = value),
              ),
              SizedBox(height: height * 0.04),

              Center(
                child: CustomButton(
                  width: width * 0.6,
                  color: Colors.black,
                  name: 'Continue',
                  on_Pressed: ()async {
                    final userinfo=await storage.getUserData();

                    try {
                      SignupService signupService = SignupService();
                      final result = await signupService.signup(
                          userinfo['fname']!, userinfo['lname']!, userinfo['email']!, userinfo['password']!);

                      if (result['success'] == true && userinfo['email'] != null) {



                        Navigator.pushNamed(
                            context, 'HomePage');
                      } else {
                        final snackBar = buildCustomSnackbar(
                          backgroundColor: Colors.redAccent,
                          title: 'Oops!',
                          message: result['message'],
                          type: ContentType.failure,
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    } catch (e) {
                      final snackBar = buildCustomSnackbar(
                        backgroundColor: Colors.redAccent,
                        title: 'Error!',
                        message: 'An unexpected error occurred.',
                        type: ContentType.failure,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
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
