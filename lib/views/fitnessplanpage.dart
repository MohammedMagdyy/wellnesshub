import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/workout_card.dart';
import '../core/utils/appimages.dart';
import '../core/widgets/custom_selectable_listbar.dart';
import '../core/widgets/main_exercisecard.dart';

class FitnessPlanPage extends StatefulWidget {
  const FitnessPlanPage({super.key});
  static const routeName = 'FitnessPlanPage';

  @override
  State<FitnessPlanPage> createState() => _FitnessPlanPageState();
}

class _FitnessPlanPageState extends State<FitnessPlanPage> {
  int selectedWeek = 0; // Default: Week 1
  int selectedDay = 0;  // Default: Day 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: ""),
      backgroundColor: const Color(0xFF7F9CF5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 120.0,
              backgroundColor: Color(0xFF7F9CF5),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                title: Text(
                  'Your Fitness Plan!',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Week",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CustomSelectableListBar(
                      title: "Week",
                      onSelected: (int x){},
                      totalIndex: 4,
                      animationDuration: const Duration(milliseconds: 400),
                      initialSelectedIndex: 0,
                      selectedColor: Colors.blue,
                      unselectedColor: Colors.white,
                      selectedTextColor: Colors.white,
                      textColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Day",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CustomSelectableListBar(
                      title: "Day",
                      onSelected: (int x){},
                      totalIndex: 5,
                      animationDuration: const Duration(milliseconds: 400),
                      initialSelectedIndex: 0,
                      selectedColor: Colors.blue,
                      unselectedColor: Colors.white,
                      selectedTextColor: Colors.white,
                      textColor: Colors.blue,
                    ),
                    const SizedBox(height: 40),
                    MainExerciseCard(
                      title: "Full Body Workout",
                      duration: "45 minutes",
                      level: "Medium",
                      imagePath: Assets.assetsImagesBigshowman,
                      page: false,
                    ),
                    const SizedBox(height: 10),
                    MainExerciseCard(
                      title: "Lower body & balance",
                      duration: "30 minutes",
                      level: "Hard",
                      imagePath: Assets.assetsImagesBackkExercise,
                      page: false,
                    ),
                    MainExerciseCard(
                      title: "Full Body Workout",
                      duration: "45 minutes",
                      level: "Medium",
                      imagePath: Assets.assetsImagesBigshowman,
                      page: false,
                    ),
                    const SizedBox(height: 10),
                    MainExerciseCard(
                      title: "Lower body & balance",
                      duration: "30 minutes",
                      level: "Hard",
                      imagePath: Assets.assetsImagesBackkExercise,
                      page: false,
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
