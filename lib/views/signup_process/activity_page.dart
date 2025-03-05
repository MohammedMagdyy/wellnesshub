import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/special_checkboxbutton.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});
  static const routeName = 'VerifyEmailPage';

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String? selectedGoal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Your activity Plan",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              width: 360,
              child: Text(
                "Please pick your desired activity Plan",
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            SpecialCheckboxbutton(
              text1: "Sedentary",
              text2: "(little or no exercise)",
              isSelected: selectedGoal == "Sedentary",
              onTap: () {
                setState(() {
                  selectedGoal = "Sedentary";
                });
              },
            ),
            SpecialCheckboxbutton(
              text1: "Lightly active",
              text2: "(1–3 days/week)",
              isSelected: selectedGoal == "Lightly active",
              onTap: () {
                setState(() {
                  selectedGoal = "Lightly active";
                });
              },
            ),
            SpecialCheckboxbutton(
              text1: "Moderately active",
              text2: "(3–5 days/week)",
              isSelected: selectedGoal == "Moderately active",
              onTap: () {
                setState(() {
                  selectedGoal = "Moderately active";
                });
              },
            ),
            SpecialCheckboxbutton(
              text1: "Very active",
              text2: "(6–7 days/week)",
              isSelected: selectedGoal == "Very active",
              onTap: () {
                setState(() {
                  selectedGoal = "Very active";
                });
              },
            ),
            Image.asset(
             Assets.assetsImagesImg,
              height: 150,
            ),
            SizedBox(height: 30),
            CustomButton(
              width: 200,
              color: Colors.black,
              name: 'Continue',
              on_Pressed: selectedGoal == null
                  ? null // Disable button if no gender is selected
                  : () {
                Navigator.pushNamed(context, "MealPlan");

              },
            ),
          ],
        ),],
      ),
    );
  }
}
