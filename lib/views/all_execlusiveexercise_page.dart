import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../constant_colors.dart';
import '../core/widgets/custom_exercise_cateogory.dart';

class AllExeclusiveExercisePage extends StatelessWidget {
  const AllExeclusiveExercisePage({super.key});
  static const routeName = 'AllExeclusiveExercisePage';

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
                  'EXCLUSIVE TRAINING!',
                  style: TextStyle(
                    color: isDark? darkForegroundTextColor : lightForegroundTextColor,
                    fontSize: 20,
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    CustomExerciseCategory(
                      name: "CARDIO",
                      imagePath: Assets.assetsImagesFitnessImg,
                      details: "10 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "RECOVERY",
                      imagePath: Assets.assetsImagesRecoveryImage,
                      details: "10 EXERCISES",
                    ),
                    CustomExerciseCategory(
                      name: "YOGA",
                      details: "9 EXERCISES",
                      imagePath: Assets.assetsImagesYogaImage,
                    ),
                    CustomExerciseCategory(
                      name: "STRETCHES",
                      details: "10 EXERCISES",
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
