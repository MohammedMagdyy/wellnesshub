import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/bmi_bar.dart';


class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  final double height = 170;
  final double weight = 70;

  double calculateBMI(double height, double weight) {
    return weight / ((height / 100) * (height / 100));
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(height, weight);

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BMIBar(bmi: bmi),
            const SizedBox(height: 10),
            Text('BMI: \${bmi.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
