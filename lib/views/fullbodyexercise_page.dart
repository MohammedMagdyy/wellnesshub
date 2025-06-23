import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../core/widgets/custom_exercise_cateogory.dart';

class FullBodyExercisePage extends StatelessWidget {
  const FullBodyExercisePage({super.key});
  static const routeName = 'FullBodyExercisePage';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(title: " "),
      backgroundColor: isDark? darkForegroundColor : lightForegroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 180.0,
              backgroundColor: isDark? darkForegroundColor : lightForegroundColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                title: Text(
                  'BE STRONGER!',
                  style: TextStyle(
                    color: isDark? darkForegroundTextColor : lightForegroundTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark? darkBackgroundColor : lightBackgroundColor,
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
