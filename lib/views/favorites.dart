import 'package:flutter/material.dart';
import 'package:wellnesshub/widgets/favorites_videos.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back icon
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
        title: const Text('Favorites'),
        titleSpacing: 100,
      ),
      body: Column(
        children: const [
          FavoriteItem(imagePath: "assets/squats.jpg", title: "Squat Exercise"),
          FavoriteItem(imagePath: "assets/stretches.jpg", title: "Full Body Stretching"),
          FavoriteItem(imagePath: "assets/plank.jpg", title: "Plank With Hip Twist"),
          FavoriteItem(imagePath: "assets/squats.jpg", title: "Push-Ups"),
          FavoriteItem(imagePath: "assets/stretches.jpg", title: "Jumping Jacks"),
          FavoriteItem(imagePath: "assets/plank.jpg", title: "Morning Yoga"),
        ],
      ),
    );
  }
}

