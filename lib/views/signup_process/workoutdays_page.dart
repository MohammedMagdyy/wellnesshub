import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import '../../core/utils/global_var.dart';
import '../../core/widgets/custom_appbar.dart';

class WorkoutDaysPage extends StatefulWidget {
  const WorkoutDaysPage({super.key});
  static const routeName = 'WorkoutDaysPage';

  @override
  _WorkoutDaysPageState createState() => _WorkoutDaysPageState();
}

class _WorkoutDaysPageState extends State<WorkoutDaysPage> {
  int? selectedDays; // Changed from String? to int?

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar(title: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                isSelected: selectedDays == 1, // Compare with int
                onTap: () => setState(() => selectedDays = 1), // Store as int
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "2 Days",
                isSelected: selectedDays == 2,
                onTap: () => setState(() => selectedDays = 2),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "3 Days",
                isSelected: selectedDays == 3,
                onTap: () => setState(() => selectedDays = 3),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "4 Days",
                isSelected: selectedDays == 4,
                onTap: () => setState(() => selectedDays = 4),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "5 Days",
                isSelected: selectedDays == 5,
                onTap: () => setState(() => selectedDays = 5),
              ),
              SizedBox(height: height * 0.0001),
              CheckboxButton(
                text: "6 Days",
                isSelected: selectedDays == 6,
                onTap: () => setState(() => selectedDays = 6),
              ),
              SizedBox(height: height * 0.05),
              CustomButton(
                width: width * 0.6,
                color: Colors.black,
                name: 'Continue',
                on_Pressed: selectedDays == null
                    ? null
                    : () async {
                  await storage.saveUserWorkoutDays(selectedDays!); // Save as int
                  Navigator.pushNamed(context, "InjuriesPage");
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