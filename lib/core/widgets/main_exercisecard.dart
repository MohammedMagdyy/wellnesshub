import 'package:flutter/material.dart';

class MainExerciseCard extends StatelessWidget {
  const MainExerciseCard(
      {super.key,
      required this.title,
      required this.duration,
      required this.level,
      required this.imagePath,
      required this.page});
  final String title, duration, level, imagePath;

  final bool page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        page
            ? Navigator.pushNamed(
                context,
                'SpecificExercisePage',
              )
            : Navigator.pushNamed(context, 'ExercisePage');
      },
      child: SizedBox(
        height: 200, // Increased height of the whole card
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text("$duration  • $level"),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    imagePath,
                    width: 110,
                    height: 200, // Increase image height here
                    fit: BoxFit.cover,
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
