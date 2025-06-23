import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_gendericon.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import '../../core/utils/global_var.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});
  static const routeName = 'GenderPage';

  @override
  State<GenderPage> createState() => _Gender_PageState();
}

class _Gender_PageState extends State<GenderPage> {
  String? selectedGender; // Stores selected gender ("Male" or "Female")

  // Maps frontend gender to backend enum values
  String _getBackendGenderValue(String? frontendGender) {
    switch (frontendGender?.toLowerCase()) {
      case 'male':
        return 'MALE';
      case 'female':
        return 'FEMALE';
      default:
        return 'MALE'; // Default value if none selected (shouldn't happen as button is disabled)
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppbar(
        title: "Gender Selection",
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  "What's Your Gender?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark? darkPrimaryTextColor : lightPrimaryTextColor
                  ),
                ),
                const SizedBox(height: 100),
                // Male Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 88),
                    CustomGenderIcon(
                      image: Assets.assetsImagesMale,
                      isSelected: selectedGender == "Male",
                      firstColor: Colors.blue,
                      selectedColor: const Color.fromARGB(255, 11, 15, 216),
                      onTap: () {
                        setState(() {
                          selectedGender = "Male";
                        });
                      },
                    ),
                    Image.asset(
                      Assets.assetsImagesMan,
                      height: 150,
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                // Female Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    Image.asset(
                      Assets.assetsImagesWomen,
                      height: 150,
                      width: 100,
                    ),
                    CustomGenderIcon(
                      image: Assets.assetsImagesFemaleL,
                      isSelected: selectedGender == "Female",
                      firstColor: Colors.pinkAccent,
                      selectedColor: const Color.fromARGB(255, 133, 3, 46),
                      onTap: () {
                        setState(() {
                          selectedGender = "Female";
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Continue Button
                CustomButton(
                  width: 200,
                  color: Colors.black,
                  name: 'Continue',
                  on_Pressed: selectedGender == null
                      ? null // Disable button if no gender is selected
                      : () async {
                    // Save the properly formatted gender value for backend
                    await storage.saveUserActivityLevel(
                        _getBackendGenderValue(selectedGender));
                    Navigator.pushNamed(context, "GoalPage");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}