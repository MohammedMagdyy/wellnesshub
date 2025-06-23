import 'package:flutter/material.dart';

import '../utils/appimages.dart';
import 'execlusive_workout_card.dart';
import 'mainpage_card.dart';

class ChallengeList extends StatelessWidget {

  const ChallengeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
       shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          width: 300,
          child: MainpageCard(
            title: "Push Ups",
            image: Assets.assetsImagesPushupImage,
            nextPage: "pushUps",
          ),
        ),
        SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          width: 300,
          child: MainpageCard(
            title: "Plank",
            image: Assets.assetsImagesPlankImage,
            nextPage: "Plank",
          ),
        ),
        SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          width:300,
          child: MainpageCard(
            title: "Squats",
            nextPage: "Squats",
            image: Assets.assetsImagesSquatImage,
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }
}
