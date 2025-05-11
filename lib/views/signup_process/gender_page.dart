import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_gendericon.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

import '../../core/utils/global_var.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});
   static const routeName = 'GenderPage';

  @override
  State<GenderPage> createState() => _Gender_PageState();
}

class _Gender_PageState extends State<GenderPage> {
  String? selectedGender; // Stores selected gender ("Male" or "Female")
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: "Gender Selection",
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
                      image: Assets.assetsImagesMale,
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
                      Assets.assetsImagesMan,
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
                      Assets.assetsImagesWomen,
                      height: 150,
                      width: 100,
                    ),
                    CustomGenderIcon(
                      image: Assets.assetsImagesFemaleL,
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
                      : () async{
                    await storage.saveUserActivityLevel(selectedGender!);
                          Navigator.pushNamed(context, "GoalPage");
                          
                        },
                ),
              ],
            ),],
          ),
        ));
  }
}
