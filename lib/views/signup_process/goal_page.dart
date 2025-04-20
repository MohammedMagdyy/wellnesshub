import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});
  static const routeName = 'GoalPage';

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String? selectedGoal;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Safe padding
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
                isSelected: selectedGoal == "Muscles Gain",
                onTap: () => setState(() => selectedGoal = "Muscles Gain"),
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
                    : () => Navigator.pushNamed(context, "ExperienceLevelPage"),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
