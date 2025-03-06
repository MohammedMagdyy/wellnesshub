import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/bmi_bar.dart';

class BMICalculator extends StatelessWidget {
  final double height = 170;
  final double weight = 70;

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(height, weight);

    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BMIBar(bmi: bmi),
          SizedBox(height: 10),
          Text('BMI: ${bmi.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
