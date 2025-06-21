import 'package:flutter/material.dart';

class ExclusiveWorkoutCard extends StatelessWidget {
  final String title;
  final String image;
  final String nextPage;

  const ExclusiveWorkoutCard({
    Key? key,
    required this.title,
    required this.image,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, nextPage);
      },
      child: Container(
        width:300,
        height: 185, // Adjust height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.lightBlueAccent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.3), // Optional dark overlay
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
