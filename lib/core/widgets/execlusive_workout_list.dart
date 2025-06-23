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
          name: "CARDIO",
          image: Assets.assetsImagesFitnessImg,
          details: "10 EXERCISES",
        ),
        SizedBox(width: 12),
        ExclusiveWorkoutCard(
          name: "RECOVERY",
          image: Assets.assetsImagesRecoveryImage,
          details: "9 EXERCISES",
        ),
        SizedBox(width: 12),
        ExclusiveWorkoutCard(
          name: "YOGA",
          details: "9 EXERCISES",
          image: Assets.assetsImagesYogaImage,
        ),
        SizedBox(width: 12),
        ExclusiveWorkoutCard(
          name: "STRETCHES",
          details: "10 EXERCISES",
          image: Assets.assetsImagesStreachImage,
        ),
        SizedBox(width: 12),
      ],
    );
  }
}
