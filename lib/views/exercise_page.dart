import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/videos.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});
  static const routeName = 'ExercisePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Exercise"),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FavoriteItem(
                imagePath:
                    Assets.assetsImagesIntrobackground, 
                title: 'Full Body Workout',
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Squat Exercise",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 16, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          "12 Minutes",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.local_fire_department,
                            size: 16, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          "120 Kcal",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    const Text(
                      "This workout is designed to target your entire body in just 12 minutes. "
                      "Make sure to warm up before you begin, and stay hydrated throughout the session. "
                      "Push yourself, but always listen to your body."
                      "This workout is designed to target your entire body in just 12 minutes. "
                      "Make sure to warm up before you begin, and stay hydrated throughout the session. "
                      "Push yourself, but always listen to your body.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 70),
                    CustomButton(
                      name: "Exercise Done",
                      width: double.infinity,
                      color: Colors.white,
                      on_Pressed: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
