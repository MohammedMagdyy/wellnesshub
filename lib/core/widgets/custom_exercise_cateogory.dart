import 'package:flutter/material.dart';

class CustomExerciseCategory extends StatelessWidget {
  const CustomExerciseCategory({
    super.key,
    required this.name,
    required this.imagePath,
    required this.details,
  });

  final String name;
  final String imagePath;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.pushNamed(context, 'SpecificExercisePage', arguments: name);
        },
        child: SizedBox(
          width: double.infinity, // Makes card full width
          height: 190, // Increased height for better visibility
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover
                      , // Ensures image covers entire area
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.error, size: 50, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                // Content
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28, // Larger font size
                            fontWeight: FontWeight.bold,
                            shadows: [
                            Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                            ),
                            ],

                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          details,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 18, // Larger font size
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}