import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/special_checkboxbutton.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});
  static const routeName = 'ActivityPage';

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String? selectedGoal;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              SizedBox(height: height * 0.02),
              Text(
                "Your Activity Plan",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.015),
              Text(
                "Please pick your desired activity plan.",
                style: TextStyle(
                  fontSize: width * 0.04,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.03),
              ...[
                ["Sedentary", "(little or no exercise)"],
                ["Lightly active", "(1–3 days/week)"],
                ["Moderately active", "(3–5 days/week)"],
                ["Very active", "(6–7 days/week)"],
              ].map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: SpecialCheckboxbutton(
                    text1: option[0],
                    text2: option[1],
                    isSelected: selectedGoal == option[0],
                    onTap: () {
                      setState(() {
                        selectedGoal = option[0];
                      });
                    },
                  ),
                );
              }).toList(),
              SizedBox(height: height * 0.03),
              Image.asset(
                Assets.assetsImagesImg,
                height: height * 0.2,
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: CustomButton(
                  width: width * 0.6,
                  color: Colors.black,
                  name: 'Continue',
                  on_Pressed: selectedGoal == null
                      ? null
                      : () {
                          Navigator.pushNamed(context, "MealPlan");
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
