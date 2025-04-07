import 'package:flutter/material.dart';

class FitnessPlanPage extends StatelessWidget {
  const FitnessPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fitness Plan',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0095FF)
          ),
        ),
      ),
      body: SafeArea(
        child: const Center(
          child: Text('fitness plan'),
        ),
      ),

    );
  }
}