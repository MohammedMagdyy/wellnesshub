import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/main_exercisecard.dart';

import '../core/widgets/custom_exercise_cateogory.dart';

class FullBodyExercisePage extends StatelessWidget {
  const FullBodyExercisePage({super.key});
  static const routeName = 'FullBodyExercisePage';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(title: " "),
      backgroundColor: isDark?Colors.black: Color(0xFF7F9CF5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 180.0,
              backgroundColor: isDark?Colors.black:Color(0xFF7F9CF5),
              flexibleSpace: const FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                title: Text(
                  'BE STRONGER!',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    CustomExerciseCategory(
                      name: "CHEST",
                      imagePath: Assets.assetsImagesChestIMg,
                      details: "11 MINS • 11 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "BACK",
                      imagePath: Assets.assetsImagesBackImg,
                      details: "11 MINS • 11 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "SHOULDER",
                      imagePath: Assets.assetsImagesShoulderImg,
                      details: "11 MINS • 11 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "ARM",
                      imagePath: Assets.assetsImagesArmImg,
                      details: "11 MINS • 11 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "LEG",
                      imagePath: Assets.assetsImagesLegImg,
                      details: "11 MINS • 11 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "CARDIO",
                      imagePath: Assets.assetsImagesFitnessImg,
                      details: "11 MINS • 11 EXERCISES",
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
