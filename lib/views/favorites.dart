import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/videos.dart';
import 'package:wellnesshub/core/utils/appimages.dart';


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  static const routeName = 'Favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0095FF),
          ),
        ),
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: const [
              FavoriteItem(imagePath: Assets.assetsImagesSquats, title: "Squat Exercise"),
              SizedBox(height: 15),
              FavoriteItem(imagePath: Assets.assetsImagesStretches, title: "Full Body Stretching"),
              SizedBox(height: 15),
              FavoriteItem(imagePath: Assets.assetsImagesPlank, title: "Plank With Hip Twist"),
              SizedBox(height: 15),
              FavoriteItem(imagePath: Assets.assetsImagesSquats, title: "Push-Ups"),
              SizedBox(height: 15),
              FavoriteItem(imagePath: Assets.assetsImagesStretches, title: "Jumping Jacks"),
              SizedBox(height: 15),
              FavoriteItem(imagePath: Assets.assetsImagesPlank, title: "Morning Yoga"),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}