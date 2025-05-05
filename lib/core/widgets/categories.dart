import 'package:flutter/material.dart';
import 'package:wellnesshub/views/community_page.dart';
import 'package:wellnesshub/views/fullbodyexercise_page.dart';
import 'package:wellnesshub/views/nutrition_page.dart';
import 'package:wellnesshub/views/progress.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _CategoryItem(
            icon: Icons.fitness_center,
            label: "Exercises",
            page: const FullBodyExercisePage()),
        _CategoryItem(
            icon: Icons.show_chart,
            label: "Progress",
            page: const ProgressPage()),
        _CategoryItem(
            icon: Icons.local_dining,
            label: "Nutrition",
            page: const NutritionPage()),
        _CategoryItem(
            icon: Icons.groups, label: "AI Coach", page: const CommunityPage()),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget page;

  const _CategoryItem(
      {required this.icon, required this.label, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Color(0xff0095FF)),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff0095FF),
            ),
          ),
        ],
      ),
    );
  }
}
