import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class PhysicalPage extends StatefulWidget {
  const PhysicalPage({super.key});

  @override
  State<PhysicalPage> createState() => _PhysicalPageState();
}

class _PhysicalPageState extends State<PhysicalPage> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            "Physical Activity Level",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            width: 360,
            child: Text(
              "Please pick your overall current  physical activity level throughout the past 3 months",
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(height: 50),
          CheckboxButton(
            text: "Beginner",
            isSelected: selectedGoal == "Beginner",
            onTap: () {
              setState(() {
                selectedGoal = "Beginner";
              });
            },
          ),
          SizedBox(height: 6),
          CheckboxButton(
            text: "Intermediate",
            isSelected: selectedGoal == "Intermediate",
            onTap: () {
              setState(() {
                selectedGoal = "Intermediate";
              });
            },
          ),
          SizedBox(height: 6),
          CheckboxButton(
            text: "Advanced",
            isSelected: selectedGoal == "Advance",
            onTap: () {
              setState(() {
                selectedGoal = "Advance";
              });
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            width: 200,
            color: Colors.black,
            name: 'Continue',
            on_Pressed: selectedGoal == null
                ? null // Disable button if no gender is selected
                : () {
                    Navigator.pushNamed(context, "InjuriesPage");
                  },
          ),
        ],
      ),
    );
  }
}
