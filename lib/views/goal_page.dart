import 'package:flutter/material.dart';
import 'package:wellnesshub/widgets/checkbox_button.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100),
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
          SizedBox(height: 70),
          CheckboxButton(),
          SizedBox(height: 6),
          CheckboxButton(),
          SizedBox(height: 6),
          CheckboxButton(),
          SizedBox(height: 6),
          CheckboxButton(),
        ],
      ),
    );
  }
}
