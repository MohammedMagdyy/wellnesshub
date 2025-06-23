import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/views/community_page.dart';
import 'package:wellnesshub/views/fullbodyexercise_page.dart';
import 'package:wellnesshub/views/nutrition_page.dart';
import 'package:wellnesshub/views/progress.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _CategoryItem(
            icon: LucideIcons.dumbbell,
            label: "Exercises",
            page: const FullBodyExercisePage()),
        _CategoryItem(
            icon: LucideIcons.trendingUp,
            label: "Progress",
            page: const ProgressPage()),
        _CategoryItem(
            icon: LucideIcons.apple,
            label: "Nutrition",
            page: const NutritionPage()),
        _CategoryItem(
            icon: LucideIcons.bot, label: "AI Coach", page: const CommunityPage()),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      child: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: isDark? darkButtonColor : lightButtonColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isDark? darkBoxShadowColor : lightBoxShadowColor,
              offset: Offset(3, 3),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ]
        ),
        child: Column(
          children: [
            Icon(icon, size: 38, color: isDark? darkIconOnButtonColor : lightIconOnButtonColor),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: isDark? darkButtonTextColor : lightButtonTextColor,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
