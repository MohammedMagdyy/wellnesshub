import 'package:flutter/material.dart';

import '../utils/appimages.dart';
import 'execlusive_workout_card.dart';

class ExclusiveWorkoutList extends StatelessWidget {

  const ExclusiveWorkoutList({
   super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
       shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        ExclusiveWorkoutCard(
          title: "CARDIO",
          image: Assets.assetsImagesFitnessImg,
          nextPage: "pushUps",
        ),
        SizedBox(width: 12),
        ExclusiveWorkoutCard(
          title: "RECOVERY",
          image: Assets.assetsImagesFitnessImg,
          nextPage: "Plank",
        ),
        SizedBox(width: 12),
        ExclusiveWorkoutCard(
          title: "BODY WEIGHT",
          nextPage: "Squats",
          image: Assets.assetsImagesFitnessImg,
        ),
        SizedBox(width: 12),
        ExclusiveWorkoutCard(
          title: "STRECH",
          nextPage: "Squats",
          image: Assets.assetsImagesFitnessImg,
        ),
        SizedBox(width: 12),
      ],
    );
  }
}
