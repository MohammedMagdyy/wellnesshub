import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

class ChallengePlank extends StatefulWidget {
  const ChallengePlank({super.key});
  static const routeName = 'Plank';

  @override
  State<ChallengePlank> createState() => _ChallengePlankState();
}

class _ChallengePlankState extends State<ChallengePlank> {
  int totalSeconds = 120 ;
  int currentSeconds = 120 ;
  Timer? timer;
  bool hasStarted = false ;


  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentSeconds > 0) {
        setState(() {
          currentSeconds--;
        });
      } else {
        timer.cancel();
        _showCongratsDialog();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
                            currentSeconds = totalSeconds ;
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

  void _showMotivationDialog() {
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
                        Icon(Icons.access_alarm, size: 60, color: Colors.amber),
                        SizedBox(height: 10),
                        Text(
                          "💪 YOU CAN DO BETTER NEXT TIME 💪",
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
                            currentSeconds = totalSeconds ;
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
    double percent = currentSeconds / totalSeconds;
    int minutes = currentSeconds ~/ 60;
    int seconds = currentSeconds % 60;

    return Scaffold(
      appBar: CustomAppbar(title: "Plank Challenge"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.all(10),
                  // width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue
                    ),
                  borderRadius: BorderRadius.circular(20)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                  Image.asset(Assets.assetsPlankGif , fit: BoxFit.fill,))
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
                  if(!hasStarted){
                    startTimer();
                    hasStarted = true ;
                  }
                  else {
                    timer?.cancel();
                    setState(() {
                      currentSeconds = totalSeconds ;
                      hasStarted = false;
                      _showMotivationDialog();
                    });
                  }
                },
                child: CircularPercentIndicator(
                  header: Column(
                    children: [
                      Text(
                        "Press Here" ,
                        style: TextStyle(
                          fontSize: 30 ,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                  radius: 150.0,
                  lineWidth: 10.0,
                  percent: percent,
                  center: Text(
                    "${minutes.toString().padLeft(2, '0')}:${seconds.toString()
                    .padLeft(2, '0')}" ,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold ,
                      color: Colors.blue
                    ),
                    ),
                  backgroundColor: const Color.fromARGB(103, 158, 158, 158),
                  progressColor: Colors.blue,
                  animation: false,
                  circularStrokeCap: CircularStrokeCap.round,
                  restartAnimation: false,
                ),
              ),
            )
          ],
        )
        ),
    );
  }
}