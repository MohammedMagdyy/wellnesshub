import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class WorkoutDaysPage extends StatefulWidget {
  const WorkoutDaysPage({super.key});
  static const routeName = 'WorkoutDaysPage';

  @override
  _WorkoutDaysPageState createState() => _WorkoutDaysPageState();
}

class _WorkoutDaysPageState extends State<WorkoutDaysPage> {
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
                "Choose Your Workout Days",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.03),
              CheckboxButton(
                text: "1 Day",
                isSelected: selectedGoal == "1 Day",
                onTap: () => setState(() => selectedGoal = "1 Day"),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "2 Days",
                isSelected: selectedGoal == "2 Days",
                onTap: () => setState(() => selectedGoal = "2 Days"),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "3 Days",
                isSelected: selectedGoal == "3 Days",
                onTap: () => setState(() => selectedGoal = "3 Days"),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "4 Days",
                isSelected: selectedGoal == "4 Days",
                onTap: () => setState(() => selectedGoal = "4 Days"),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "5 Days",
                isSelected: selectedGoal == "5 Days",
                onTap: () => setState(() => selectedGoal = "5 Days"),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "6 Days",
                isSelected: selectedGoal == "6 Days",
                onTap: () => setState(() => selectedGoal = "6 Days"),
              ),
              SizedBox(height: height * 0.05),
              CustomButton(
                width: width * 0.6,
                color: Colors.black,
                name: 'Continue',
                on_Pressed: selectedGoal == null
                    ? null
                    : () => Navigator.pushNamed(context, "InjuriesPage"),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
