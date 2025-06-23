import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});
  static const routeName = 'GoalPage';

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String? selectedGoal;
  /*
  Weight Cut / Muscle Gain / Increase Strength
   */

  // Maps frontend goal text to backend enum values
  String _getBackendGoalValue(String? frontendGoal) {
    switch (frontendGoal?.toLowerCase()) {
      case 'weight cut':
        return 'WEIGHT_CUT';
      case 'muscles gain':
        return 'BUILD_MUSCLE'; // Matches backend enum
      case 'increasing strength':
        return 'INCREASE_STRENGTH'; // Matches backend enum
      default:
        return 'WEIGHT_CUT'; // Default value
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar(
        title: "Goal Page",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.02),
              Text(
                "What is Your Goal?",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.03),
              CheckboxButton(
                text: "Weight Cut",
                isSelected: selectedGoal == "Weight Cut",
                onTap: () => setState(() => selectedGoal = "Weight Cut"),
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Muscles Gain",
                isSelected: selectedGoal == "muscles gain",
                onTap: () => setState(() => selectedGoal = "muscles gain"),
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Increasing Strength",
                isSelected: selectedGoal == "Increasing Strength",
                onTap: () => setState(() => selectedGoal = "Increasing Strength"),
              ),
              SizedBox(height: height * 0.03),
              Image.asset(
                Assets.assetsImagesBigshowman,
                height: height * 0.2,
              ),
              SizedBox(height: height * 0.05),
              CustomButton(
                width: width * 0.6,
                color: Colors.black,
                name: 'Continue',
                on_Pressed: selectedGoal == null
                    ? null
                    : () async {
                  // Save the properly formatted goal value for backend
                  await storage.saveUserGoal(
                      _getBackendGoalValue(selectedGoal!));
                  Navigator.pushNamed(context, "ExperienceLevelPage");
                },
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}