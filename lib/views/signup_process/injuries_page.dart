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
    return  Scaffold(
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
              "Do you Suffer from any injuries?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              width: 360,
              child: Text(
                "Choose the injured area you’re suffering from or if you don’t find it choose None",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            CheckboxButton(
              text: "Shoulder",
              isSelected: selectedGoal == "Shoulder",
              onTap: () {
                setState(() {
                  selectedGoal = "Shoulder";
                });
              },
            ),
           
            CheckboxButton(
              text: "Chest",
              isSelected: selectedGoal == "Chest",
              onTap: () {
                setState(() {
                  selectedGoal = "Chest";
                });
              },
            ),
            
            CheckboxButton(
              text: "Arm",
              isSelected: selectedGoal == "Arm",
              onTap: () {
                setState(() {
                  selectedGoal = "Arm";
                });
              },
            ),
           
            CheckboxButton(
              text: "Knee",
              isSelected: selectedGoal == "Knee",
              onTap: () {
                setState(() {
                  selectedGoal = "Knee";
                });
              },
            ),
            
            CheckboxButton(
              text: "Ankle",
              isSelected: selectedGoal == "Ankle",
              onTap: () {
                setState(() {
                  selectedGoal = "Ankle";
                });
              },
            ),
            
            CheckboxButton(
              text: "None",
              isSelected: selectedGoal == "None",
              onTap: () {
                setState(() {
                  selectedGoal = "None";
                });
              },
            ),
            SizedBox(height: 5),
            CustomButton(
              width: 200,
              color: Colors.black,
              name: 'Continue',
              on_Pressed: selectedGoal == null
                  ? null // Disable button if no gender is selected
                  : () {
                    Navigator.pushNamed(context, "ActivityPage");
                     
                    },
            ),
          ],
        ),],
      ),
    );
  }
}