import 'package:flutter/material.dart';
import 'package:wellnesshub/widgets/custom_button.dart';
import 'package:wellnesshub/widgets/custom_gendericon.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _Gender_PageState();
}

class _Gender_PageState extends State<GenderPage> {
  String? selectedGender; // Stores selected gender ("Male" or "Female")
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
        body: SafeArea(
          child: ListView(
            children: [
              Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "What's Your Gender?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                //Male
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 88,
                    ),
                    CustomGenderIcon(
                      image: 'assets/Male.png',
                      isSelected: selectedGender == "Male",
                      firstColor: Colors.blue,
                      selectedColor: const Color.fromARGB(255, 11, 15, 216),
                      onTap: () {
                        setState(() {
                          selectedGender = "Male";
                        });
                      },
                    ),
                    Image.asset(
                      'assets/Man.png',
                      height: 150,
                      width: 100,
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                //Female
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      'assets/Women.png',
                      height: 150,
                      width: 100,
                    ),
                    CustomGenderIcon(
                      image: 'assets/FemaleL.png',
                      isSelected: selectedGender == "Female",
                      firstColor: Colors.pinkAccent,
                      selectedColor: const Color.fromARGB(255, 133, 3, 46),
                      onTap: () {
                        setState(() {
                          selectedGender = "Female";
                          print(selectedGender);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                //Skip button
                CustomButton(
                  width: 200,
                  color: Colors.black,
                  name: 'Continue',
                  on_Pressed: selectedGender == null
                      ? null // Disable button if no gender is selected
                      : () {
                          Navigator.pushNamed(context, "GoalPage");
                          
                        },
                ),
              ],
            ),],
          ),
        ));
  }
}
