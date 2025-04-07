import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});
  static const routeName = 'StartUp';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.assetsImagesIntrobackground),
                      fit: BoxFit.cover))),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(Assets.assetsImagesHeartIcon),
              SizedBox(height: 5),
              Text(
                "The Wellness Hub",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Calibri"),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Welcome to The Wellness Hub \n A user friendly gateway to a healthier lifestyle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 150),
              MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'LoginPage');
                },
                animationDuration: Duration(milliseconds: 500),
                color: Color(0xff0095FF),
                elevation: 2,
                minWidth: 350,
                height: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'SignUpPage');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xff0095FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
            ],
          )
        ],
      )),
    );
  }
}
