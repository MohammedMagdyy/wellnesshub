import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/checkbox_button.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.015),
            Text(
              "Choose the injured area you’re suffering from or if you don’t find it, choose None.",
              style: TextStyle(
                fontSize: width * 0.04,
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
                    : () => Navigator.pushNamed(context, "ActivityPage"),
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}
