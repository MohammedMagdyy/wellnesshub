import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../core/widgets/custom_exercise_cateogory.dart';

class AllExeclusiveExercisePage extends StatelessWidget {
  const AllExeclusiveExercisePage({super.key});
  static const routeName = 'AllExeclusiveExercisePage';

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
                      name: "CARDIO",
                      imagePath: Assets.assetsImagesFitnessImg,
                      details: "11 MINS • 11 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "RECOVERY",
                      imagePath: Assets.assetsImagesRecoveryImage,
                      details: "11 MINS • 11 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "YOGA",
                      details: "11 MINS • 11 EXERCISES",
                      imagePath: Assets.assetsImagesYogaImage,
                    ),
                    CustomExerciseCategory(
                      name: "STRETCHES",
                      details: "11 MINS • 11 EXERCISES",
                      imagePath: Assets.assetsImagesStreachImage,
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
