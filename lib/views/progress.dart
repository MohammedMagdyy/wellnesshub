import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});
  static const routeName = 'ProgressPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Progress"),
      body: SafeArea(
        child: const Center(
          child: Text('Progress Page'),
        ),
      ),
    );
  }
}
