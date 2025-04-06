import 'package:flutter/material.dart';



class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});
  static const routeName = 'ProgressPage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Center(
        child: Text('Progress Page'),
      ),
    );
  }
}