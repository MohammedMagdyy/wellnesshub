import 'package:flutter/material.dart';
import 'package:wellnesshub/widgets/custom_comingsoon.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomComingsoon(
      title: "Nutrition Page",
      image: "assets/Nutrition.jpeg"
      );
  }
}
