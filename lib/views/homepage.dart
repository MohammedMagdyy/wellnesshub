import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/homepage_header.dart';
import 'package:wellnesshub/core/widgets/mainpage_card.dart';
import 'package:wellnesshub/core/widgets/search_bar.dart';
import 'package:wellnesshub/core/widgets/categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Header(),
                const SizedBox(height: 30),
                SearchBarWidget(),
                const SizedBox(height: 30),
                // Wrap Categories in an Expanded or Flexible if necessary
                const Categories(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Exclusive workout sets",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff0095FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff0095FF),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
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
                          child: MainpageCard(
                            title: "Push Ups",
                            image: Assets.assetsImagesPushUps,
                            nextPage: "pushUps",
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(
                            title: "Plank",
                            image: Assets.assetsImagesPlank,
                            nextPage: "Plank",
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(
                            title: "Squats",
                            nextPage: "Squats",
                            image: Assets.assetsImagesSquats,
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Quick workout sets",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff0095FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff0095FF),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
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
                          child: MainpageCard(
                            title: "Push Ups",
                            image: Assets.assetsImagesPushUps,
                            nextPage: "pushUps",
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(
                            title: "Plank",
                            image: Assets.assetsImagesPlank,
                            nextPage: "Plank",
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(
                            title: "Squats",
                            nextPage: "Squats",
                            image: Assets.assetsImagesSquats,
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Challenges",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff0095FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff0095FF),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
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
                          child: MainpageCard(
                            title: "Push Ups",
                            image: Assets.assetsImagesPushUps,
                            nextPage: "pushUps",
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(
                            title: "Plank",
                            image: Assets.assetsImagesPlank,
                            nextPage: "Plank",
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          width: 260,
                          child: MainpageCard(
                            title: "Squats",
                            nextPage: "Squats",
                            image: Assets.assetsImagesSquats,
                          ),
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
