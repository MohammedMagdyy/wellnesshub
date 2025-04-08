import 'package:flutter/material.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({super.key, required this.imagePath, required this.title});
  final String imagePath, title;
  @override
  _FavoriteItemState createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(widget.imagePath,
              width: double.infinity, height: 220, fit: BoxFit.cover),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: toggleFavorite,
            child: Icon(
              Icons.star,
              color: isFavorite ? Colors.blue : Colors.white,
              size: 30,
            ),
          ),
        ),
        Positioned(
          left: 100,
          top: 80,
          right: 100,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: 0.4),
                // borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.play_circle_outlined,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
