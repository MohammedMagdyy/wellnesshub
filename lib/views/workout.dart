import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/videos.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FavoriteItem(
              imagePath: Assets.assetsImagesSquats, // 👈 use your assets reference
              title: 'Full Body Workout',
            ),
            const SizedBox(height: 16),
            const Text(
              "This workout is designed to target your entire body in just 12 minutes. "
                  "Make sure to warm up before you begin, and stay hydrated throughout the session. "
                  "Push yourself, but always listen to your body.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}