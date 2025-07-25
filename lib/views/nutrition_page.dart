import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_comingsoon.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});
  static const routeName = 'NutritionPage';

  @override
  Widget build(BuildContext context) {
    return CustomComingsoon(
      title: "Nutrition Page",
      image: Assets.assetsImagesNutritionPage,
    );
  }
}
