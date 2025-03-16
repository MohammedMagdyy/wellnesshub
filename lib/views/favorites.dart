import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/videos.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/navigation_bar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  static const routeName = 'Favorites';

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _selectedIndex = 2; // Set index for Favorites tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back icon
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
