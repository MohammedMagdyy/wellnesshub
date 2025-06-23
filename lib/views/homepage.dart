import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/homepage_header.dart';
import 'package:wellnesshub/core/widgets/mainpage_card.dart';
import 'package:wellnesshub/core/widgets/search_bar.dart';
import 'package:wellnesshub/core/widgets/categories.dart';

import '../core/widgets/challenge_list.dart';
import '../core/widgets/execlusive_workout_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = 'HomePage';

  @override
  Widget build(BuildContext context) {
    final List<String> words = ["Show", "Your", "PLan"];
    double screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                const SizedBox(height: 40),
                const Categories(),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "FitnessPlanPage");
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth * 0.85,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  isDark
                                      ? darkImportantButtonStart
                                      : lightImportantButtonStart,
                                  isDark
                                      ? darkImportantButtonEnd
                                      : lightImportantButtonEnd
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark? darkBoxShadowColor : lightBoxShadowColor,
                                  offset: Offset(5, 5),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                ),
                              ]),
                          child: Text(
                            'SHOW YOUR\nPLAN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              color: isDark? darkButtonTextColor : lightButtonTextColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Exclusive workout sets",
                      style: TextStyle(
                        fontSize: 18,
                        color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "AllExeclusiveExercisePage");
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: isDark? darkSecondaryTextColor : lightSecondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExclusiveWorkoutList(),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Challenges",
                      style: TextStyle(
                        fontSize: 18,
                        color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'ChallengePage');
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: isDark? darkSecondaryTextColor : lightSecondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChallengeList(),
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
