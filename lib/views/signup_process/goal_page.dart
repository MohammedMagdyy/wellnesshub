import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});
  static const routeName = 'GoalPage';

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String? selectedGoal; // Track selected goal

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
            "What is Your Goal?",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            width: 360,
            child: Text(
              "Choose the goal you’re hoping to achieve",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 50),
          CheckboxButton(
            text: "Lose Weight",
            isSelected: selectedGoal == "Lose Weight",
            onTap: () {
              setState(() {
                selectedGoal = "Lose Weight";
              });
            },
          ),
          SizedBox(height: 6),
          CheckboxButton(
            text: "Gain Weight",
            isSelected: selectedGoal == "Gain Weight",
            onTap: () {
              setState(() {
                selectedGoal = "Gain Weight";
              });
            },
          ),
          SizedBox(height: 6),
          CheckboxButton(
            text: "Muscle Mass Gain",
            isSelected: selectedGoal == "Muscle Mass Gain",
            onTap: () {
              setState(() {
                selectedGoal = "Muscle Mass Gain";
              });
            },
          ),
          SizedBox(height: 6),
          CheckboxButton(
            text: "Shape Body",
            isSelected: selectedGoal == "Shape Body",
            onTap: () {
              setState(() {
                selectedGoal = "Shape Body";
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
                   //avigator.pushNamed(context, "GoalPage");
                  },
          ),
        ],
      ),
    );
  }
}
