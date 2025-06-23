import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/special_checkboxbutton.dart';
import '../../core/utils/global_var.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});
  static const routeName = 'ActivityPage';

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String? selectedActivity;

  //Directly uses the enum string values to ensure perfect backend compatibility
  static const Map<String, String> activityOptions = {
    'Sedentary': '(little or no exercise)',
    'Lightly_active': '(1–3 days/week)',
    'Moderately_active': '(3–5 days/week)',
    'Very active': '(6–7 days/week)',
  };
  // static const Map<String, String> activityOptions = {
  //   'Sedentary': '(little or no exercise)',
  //   'Lightly active': '(1–3 days/week)',
  //   'Moderately active': '(3–5 days/week)',
  //   'Very active': '(6–7 days/week)',
  // };


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppbar(title: "Activity Level"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              Text(
                "Your Activity Level",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.015),
              Text(
                "Please select your current activity level.",
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.03),
              Expanded(
                child: ListView(
                  children: activityOptions.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: SpecialCheckboxbutton(
                        text1: entry.key,
                        text2: entry.value,
                        isSelected: selectedActivity == entry.key,
                        onTap: () => setState(() => selectedActivity = entry.key),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Image.asset(
                Assets.assetsImagesImg,
                height: height * 0.2,
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.04),
                child: Center(
                  child: CustomButton(
                    width: width * 0.6,
                    color: Colors.black,
                    name: 'Continue',
                    on_Pressed: selectedActivity == null
                        ? null
                        : () async {
                      // No conversion needed since we're using exact enum strings
                      await storage.saveUserActivityLevel(selectedActivity!);
                      Navigator.pushNamed(context, "WorkoutDaysPage");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}