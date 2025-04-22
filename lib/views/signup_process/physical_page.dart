import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

class PhysicalPage extends StatefulWidget {
  const PhysicalPage({super.key});
  static const routeName = 'PhysicalPage';

  @override
  State<PhysicalPage> createState() => _PhysicalPageState();
}

class _PhysicalPageState extends State<PhysicalPage> {
  String? selectedGoal;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Physical Activity Level",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: width * 0.07, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: height * 0.03),
              Text(
                "Please pick your overall current physical activity level throughout the past 3 months",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.04),
              ),
              SizedBox(height: height * 0.05),
              CheckboxButton(
                text: "Beginner",
                isSelected: selectedGoal == "Beginner",
                onTap: () {
                  setState(() {
                    selectedGoal = "Beginner";
                  });
                },
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Intermediate",
                isSelected: selectedGoal == "Intermediate",
                onTap: () {
                  setState(() {
                    selectedGoal = "Intermediate";
                  });
                },
              ),
              SizedBox(height: height * 0.015),
              CheckboxButton(
                text: "Advanced",
                isSelected: selectedGoal == "Advanced", // fixed: was "Advance"
                onTap: () {
                  setState(() {
                    selectedGoal = "Advanced";
                  });
                },
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: CustomButton(
                  width: width * 0.6,
                  color: Colors.black,
                  name: 'Continue',
                  on_Pressed: selectedGoal == null
                      ? null
                      : () {
                          Navigator.pushNamed(context, "InjuriesPage");
                        },
                ),
              ),
              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
