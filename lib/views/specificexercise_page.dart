import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/main_exercisecard.dart';

import '../core/models/fitness_plan/planexercises_model.dart';
import '../core/services/workout_plan/workoutplan_service.dart';

class SpecificExercisePage extends StatefulWidget {
  const SpecificExercisePage({super.key, required this.title});
  static const routeName = 'SpecificExercisePage';
  final String title;

  @override
  State<SpecificExercisePage> createState() => _SpecificExercisePageState();
}


class _SpecificExercisePageState extends State<SpecificExercisePage> {


  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: " "),
      backgroundColor: const Color(0xFF7F9CF5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: false,
              expandedHeight: 150.0,
              backgroundColor: Color(0xFF7F9CF5),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                title: Text(
                  widget.title,
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
                    // MainExerciseCard(
                    //   title: "Full Body Workout",
                    //   sets: "45 minutes",
                    //   targetMuscle: "Medium",
                    //   imagePath: Assets.assetsImagesBigshowman,
                    //   page: false,
                    // ),

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
