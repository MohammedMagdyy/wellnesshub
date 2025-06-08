import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../core/helper_functions/simplify_errormessage.dart';
import '../core/models/fitness_plan/planexercises_model.dart';
import '../core/services/workout_plan/workoutplan_service.dart';
import '../core/widgets/custom_selectable_listbar.dart';
import '../core/widgets/error_widget.dart';
import '../core/widgets/main_exercisecard.dart';
import '../core/widgets/server_error_widget.dart';


class FitnessPlanPage extends StatefulWidget {
  const FitnessPlanPage({super.key});
  static const routeName = 'FitnessPlanPage';

  @override
  State<FitnessPlanPage> createState() => _FitnessPlanPageState();
}

class _FitnessPlanPageState extends State<FitnessPlanPage> {
  int selectedWeek = 0; // Default: Week 1
  int selectedDay = 0;  // Default: Day 1
  late Future<ExercisePlan> _exercisePlanFuture;

  Future<void> _retryFetch() async {
    setState(() {
      _exercisePlanFuture = WorkoutPlanService().fetchUserPlan();
    });
  }

  @override
  void initState()  {
    super.initState();
    _exercisePlanFuture = WorkoutPlanService().fetchUserPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7F9CF5),
      appBar: CustomAppbar(title: ""),
      body: SafeArea(
        child: FutureBuilder<ExercisePlan>(
          future: _exercisePlanFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              if (snapshot.error.toString().contains('server')) {
                return ServerErrorWidget(onRetry: _retryFetch);
              }
              // General error handling
              return ErrorDisplayWidget(
                errorMessage: simplifyErrorMessage(snapshot.error.toString()),
                onRetry: _retryFetch,
              );
            } else if (!snapshot.hasData || snapshot.data!.weeks.isEmpty) {
              return ErrorDisplayWidget(
                errorMessage: 'No fitness plan found. Please check back later.',
                onRetry: _retryFetch,
                icon: Icons.search_off,
                color: Colors.orange,
              );
            }

            final plan = snapshot.data!;
            final weeks = plan.weeks;

            // Handle bounds (in case fewer than 5 weeks/days)
            final week = weeks[selectedWeek < weeks.length ? selectedWeek : 0];
            final days = week.days;
            final day = days[selectedDay < days.length ? selectedDay : 0];

            return CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: 140.0,
                  backgroundColor: Color(0xFF7F9CF5),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                    title: Text(
                      'Your Fitness Plan!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Week",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        CustomSelectableListBar(
                          title: "Week",
                          onSelected: (int x) {
                            setState(() {
                              selectedWeek = x;
                              selectedDay = 0; // reset to Day 1 when changing week
                            });
                          },
                          totalIndex: weeks.length,
                          animationDuration: const Duration(milliseconds: 400),
                          initialSelectedIndex: selectedWeek,
                          selectedColor: Colors.blue,
                          unselectedColor: Colors.white,
                          selectedTextColor: Colors.white,
                          textColor: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Day",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        CustomSelectableListBar(
                          title: "Day",
                          onSelected: (int x) {
                            setState(() {
                              selectedDay = x;
                            });
                          },
                          totalIndex: days.length,
                          animationDuration: const Duration(milliseconds: 400),
                          initialSelectedIndex: selectedDay,
                          selectedColor: Colors.blue,
                          unselectedColor: Colors.white,
                          selectedTextColor: Colors.white,
                          textColor: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        ...day.exercises.map((exercise) =>
                            MainExerciseCardFitnessPlan(
                          exercise: exercise,
                          weekId: week.id,
                          dayId: day.id,
                        ),),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
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

