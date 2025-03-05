import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/favorites_videos.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  static const routeName = 'Favorites';

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
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FavoriteItem(imagePath: Assets.assetsImagesSquats, title: "Squat Exercise"),
            FavoriteItem(imagePath: Assets.assetsImagesStretches, title: "Full Body Stretching"),
            FavoriteItem(imagePath: Assets.assetsImagesPlank, title: "Plank With Hip Twist"),
            FavoriteItem(imagePath: Assets.assetsImagesSquats, title: "Push-Ups"),
            FavoriteItem(imagePath: Assets.assetsImagesStretches, title: "Jumping Jacks"),
            FavoriteItem(imagePath: Assets.assetsImagesPlank, title: "Morning Yoga"),
          ],
        ),
      ),
    );
  }
}

