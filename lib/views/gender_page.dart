import 'package:flutter/material.dart';
import 'package:wellnesshub/widgets/custom_button.dart';
import 'package:wellnesshub/widgets/custom_gendericon.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _Gender_PageState();
}

class _Gender_PageState extends State<GenderPage> {
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
          child: Column(
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
                  CustomGendericon(
                      imagee: 'assets/Male.png',
                      firstColor: Colors.lightBlueAccent,
                      spalshColor:  Color.fromRGBO(0, 0, 255, 2)),
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
                  CustomGendericon(
                      imagee: 'assets/FemaleL.png',
                      firstColor: const Color.fromARGB(255, 201, 117, 145),
                      spalshColor: Colors.red),
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
                on_Pressed: () {
                  // Navigate to next screen
                },
              ),
            ],
          ),
        ));
  }
}
