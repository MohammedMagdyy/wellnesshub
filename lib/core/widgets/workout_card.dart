import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({super.key});

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Stack(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        Assets.workout1,
                        fit: BoxFit.cover,
                        width: double.infinity
                        ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Workout Name" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  Icon(Icons.timer, size: 15, color: Colors.blue),
                                  SizedBox(width: 1),
                                  Text("12 minutes" , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5,),
                                  Icon(Icons.local_fire_department, size: 15, color: Colors.blue),
                                  SizedBox(width: 1),
                                  Text("120 Kcal" , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),)
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withValues(alpha: 0.4)
                  ),
                  child: Icon(Icons.play_circle_outlined , color: Colors.white, size: 50,),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: toggleFavorite,
                child: Icon(
                Icons.star,
                color: isFavorite ? Colors.blue : Colors.white,
                size: 30,),
              ),
            )
          ],
        ),
      ),
    );
  }
}