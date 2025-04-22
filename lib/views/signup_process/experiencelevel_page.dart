import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class ExperienceLevelPage extends StatefulWidget {
  const ExperienceLevelPage({super.key});
  static const routeName = 'ExperienceLevelPage';

  @override
  _ExperienceLevelPageState createState() => _ExperienceLevelPageState();
}

class _ExperienceLevelPageState extends State<ExperienceLevelPage> {
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
                "What is Your Experience Level?",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.03),
              CheckboxButton(
                text: "Begineer",
                isSelected: selectedGoal == "Begineer",
                onTap: () => setState(() => selectedGoal = "Begineer"),
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Intermediate",
                isSelected: selectedGoal == "Intermediate",
                onTap: () => setState(() => selectedGoal = "Intermediate"),
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Advanced",
                isSelected: selectedGoal == "Advanced",
                onTap: () => setState(() => selectedGoal = "Advanced"),
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
                    : () => Navigator.pushNamed(context, "WorkoutDaysPage"),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
