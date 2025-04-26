import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChallengeSquats extends StatefulWidget {
  const ChallengeSquats({super.key});
  static const routeName = 'Squats';

  @override
  State<ChallengeSquats> createState() => _ChallengeSquatsState();
}

class _ChallengeSquatsState extends State<ChallengeSquats> {
double progress = 0 ;
  int counter = 0 ;

  void _showCongratsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.celebration, size: 60, color: Colors.amber),
                        SizedBox(height: 10),
                        Text(
                          "🎉 Congratulations! 🎉",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            counter = 0;
                            progress = 0;
                          });
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Squats Challenge"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    )
                  ),
                  child: Image.asset(Assets.assetsSquatsGif , fit: BoxFit.fill,)
                  ),
              ),
            ),
            
            Expanded(
              flex: 2,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                enableFeedback: true,
                onPressed: () {
                  setState(() {
                    counter ++ ;
                    progress = (counter / 20);
                    if (counter == 20) {
                      Future.delayed(Duration(milliseconds: 100), () {
                        _showCongratsDialog();
                      });
                    }
                  });
                },
                child: CircularPercentIndicator(
                  header: Text(
                    "Press Here" ,
                    style: TextStyle(
                      fontSize: 30 ,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  radius: 150.0,
                  lineWidth: 10.0,
                  percent: progress,
                  center: Text(
                    "$counter" ,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold ,
                      color: Colors.blue
                    ),
                    ),
                  backgroundColor: const Color.fromARGB(103, 158, 158, 158),
                  progressColor: Colors.blue,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  restartAnimation: true,
                ),
              ),
            )
          ],
        )
        ),
    );
  }
}