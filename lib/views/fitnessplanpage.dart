import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/workout_card.dart';

class FitnessPlanPage extends StatefulWidget {
  const FitnessPlanPage({super.key});
  static const routeName = 'FitnessPlanPage';

  @override
  State<FitnessPlanPage> createState() => _FitnessPlanPageState();
}

class _FitnessPlanPageState extends State<FitnessPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Fitness Plan"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Workouts For Today",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: WorkoutCard(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "History",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      return const WorkoutCard();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomCard extends StatelessWidget {
  const MyCustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(child: Text("Magdy")),
    );
  }
}


/*
 we need Custom Widget To Contain Above Widget
 -->
 FutureBuilder<List<ExercisesModel>>(
 future: ExerciseService().getExercisesData(),
 builder:(context,snapshot){
 if(snapshot.hasData){
 List<ExerciseModel>exercises=snapshot.data!;
 return GridView.builder(
 
 
 );
 
 }else{
 return CircularProgressIndicator();
 }
 }
 
 )

*/