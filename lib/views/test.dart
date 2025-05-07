import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/mainpage_card.dart';
import 'package:wellnesshub/core/widgets/workout_card.dart';

class Test extends StatelessWidget {
  const Test({super.key});
  static const routeName = 'Test';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        // child: Center(child: WorkoutCard_Plan()),
        child: SizedBox(
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(title: "Push Ups", image: Assets.assetsPushupsGif),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(title: "Plank", image: Assets.assetsPlankGif),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(title: "Squats", image: Assets.assetsSquatsGif),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
