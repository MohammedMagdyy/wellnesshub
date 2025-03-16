import 'package:flutter/material.dart';

class FavoriteItem extends StatefulWidget {
  final String imagePath, title;
  const FavoriteItem({super.key, required this.imagePath, required this.title});

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
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(widget.imagePath, width: double.infinity, height: 150, fit: BoxFit.cover),
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
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                  backgroundColor: Colors.black54,
                ),
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  Icon(Icons.timer, size: 16, color: Colors.white),
                  SizedBox(width: 5),
                  Text("12 Minutes", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.local_fire_department, size: 16, color: Colors.red),
                  SizedBox(width: 5),
                  Text("120 Kcal", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
