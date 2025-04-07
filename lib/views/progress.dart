import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});
  static const routeName = 'ProgressPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Progress ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        
      ),
      body: SafeArea(
        child: const Center(
          child: Text('Progress Page'),
        ),
      ),
    );
  }
}
