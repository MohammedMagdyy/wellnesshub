import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/workout_card.dart';

class Test extends StatelessWidget {
  const Test({super.key});
  static const routeName = 'Test';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: WorkoutCard()),
      ),
    );
  }
}