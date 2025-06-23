import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/challenge_card.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  static const routeName = 'ChallengePage';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppbar(title: "Challenges"),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15),

          children: [
            Container(
                height: 200,
                width: 150,
                child: ChallengeCard(
                    title: "Push Ups",
                    image: Assets.assetsImagesPushUps,
                    nextPage: "pushUps")
            ),
            SizedBox(height: 15,),
            Container(
              height: 200,
              width: 150,
              child: ChallengeCard(
                  title: "Plank",
                  image: Assets.assetsImagesPlank,
                  nextPage: "Plank")
            ),
            SizedBox(height: 15,),
            Container(
                height: 200,
                width: 150,
                child: ChallengeCard(
                    title: "Squats",
                    image: Assets.assetsImagesSquats,
                    nextPage: "Squats")
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}