import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class ExperienceLevelPage extends StatefulWidget {
  const ExperienceLevelPage({super.key});
  static const routeName = 'ExperienceLevelPage';

  @override
  _ExperienceLevelPageState createState() => _ExperienceLevelPageState();
}

class _ExperienceLevelPageState extends State<ExperienceLevelPage> {
  String? selectedExperience;

  // Maps frontend selection to backend enum values
  String _getBackendExperienceValue(String? frontendExperience) {
    switch (frontendExperience?.toLowerCase()) {
      case 'beginner':
        return 'BEGINNER';
      case 'intermediate':
        return 'INTERMEDIATE';
      case 'advanced':
        return 'ADVANCED';
      default:
        return 'BEGINNER'; // Default value
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Scaffold(
      appBar: CustomAppbar(
        title: "Experience Level",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.02),
              Text(
                "What is Your Experience Level?",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: isDark? darkPrimaryTextColor : lightPrimaryTextColor
                ),
              ),
              SizedBox(height: height * 0.03),
              CheckboxButton(
                text: "Beginner", // Fixed typo from "Begineer"
                isSelected: selectedExperience == "Beginner",
                onTap: () => setState(() => selectedExperience = "Beginner"),
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Intermediate",
                isSelected: selectedExperience == "Intermediate",
                onTap: () => setState(() => selectedExperience = "Intermediate"),
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Advanced",
                isSelected: selectedExperience == "Advanced",
                onTap: () => setState(() => selectedExperience = "Advanced"),
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
                on_Pressed: selectedExperience == null
                    ? null
                    : () async {
                  await storage.saveUserExperienceLevel(
                      _getBackendExperienceValue(selectedExperience));
                  Navigator.pushNamed(context, "ActivityPage");
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