import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/main_exercisecard.dart';

class FullBodyExercisePage extends StatelessWidget {
  const FullBodyExercisePage({super.key});
  static const routeName = 'FullBodyExercisePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: " "),
      backgroundColor: const Color(0xFF7F9CF5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 180.0,
              backgroundColor: Color(0xFF7F9CF5),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                title: Text(
                  'Choose Your Exercise!',
                  style: TextStyle(
                    color: Colors.white,
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
                    MainExerciseCard(
                      title: "Full Body Workout",
                      duration: "45 minutes",
                      level: "Medium",
                      imagePath: Assets.assetsImagesBigshowman,
                      page: true,
                    ),
                    MainExerciseCard(
                      title: "Lower body & balance",
                      duration: "30 minutes",
                      level: "Hard",
                      imagePath: Assets.assetsImagesBackkExercise,
                      page: true,
                    ),
                    MainExerciseCard(
                      title: "Cardio Blast",
                      duration: "20 minutes",
                      level: "Easy",
                      imagePath: Assets.assetsImagesBigshowman,
                      page: true,
                    ),
                    MainExerciseCard(
                      title: "Stretching & Mobility",
                      duration: "15 minutes",
                      level: "Beginner",
                      imagePath: Assets.assetsImagesBigshowman,
                      page: true,
                    ),
                    MainExerciseCard(
                      title: "Upper body & core",
                      duration: "25 minutes",
                      level: "Medium",
                      imagePath: Assets.assetsImagesBigshowman,
                      page: true,
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
