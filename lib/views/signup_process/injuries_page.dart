import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class InjuriesPage extends StatefulWidget {
  const InjuriesPage({super.key});
  static const routeName = 'InjuriesPage';

  @override
  State<InjuriesPage> createState() => _InjuriesPageState();
}

class _InjuriesPageState extends State<InjuriesPage> {
  String? selectedGoal;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Scaffold(
      appBar: CustomAppbar(
        title: "",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            SizedBox(height: height * 0.02),
            Text(
              "Do you suffer from any injuries?",
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
                color: isDark? darkPrimaryTextColor : lightPrimaryTextColor
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.015),
            Text(
              "Choose the injured area you’re suffering from or if you don’t find it, choose None.",
              style: TextStyle(
                fontSize: width * 0.04,
                color: isDark? darkSecondaryTextColor : lightSecondaryTextColor
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.03),
            ...["Shoulder", "Chest", "Arm", "Knee", "Ankle", "None"].map((injury) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CheckboxButton(
                  text: injury,
                  isSelected: selectedGoal == injury,
                  onTap: () {
                    setState(() {
                      selectedGoal = injury;
                    });
                  },
                ),
              );
            }),
            SizedBox(height: height * 0.04),
            Center(
              child: CustomButton(
                width: width * 0.6,
                color: Colors.black,
                name: 'Continue',
                on_Pressed: selectedGoal == null
                    ? null
                    : () async{
                  await storage.saveUserInjury(selectedGoal!);
                  Navigator.pushNamed(context, "MealPlan");
                }
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}
