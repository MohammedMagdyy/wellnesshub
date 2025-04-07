import 'package:flutter/material.dart';

class BMIBar extends StatefulWidget {
  final double bmi;

  const BMIBar({super.key, required this.bmi});

  @override
  State<BMIBar> createState() => _BMIBarState();
}

class _BMIBarState extends State<BMIBar> {
  double _getAlignment() {
    if (widget.bmi < 15) return -1.0;
    if (widget.bmi > 40) return 1.0;
    return (widget.bmi - 15) / 25 * 2 - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 20,
      child: Stack(
        children: [
          Row(
            children: [
              _buildSegment(15, 16, Colors.cyan),
              _buildSegment(16, 18.5, Colors.blue),
              _buildSegment(18.5, 25, Colors.green),
              _buildSegment(25, 30, Colors.yellow),
              _buildSegment(30, 35, Colors.orange),
              _buildSegment(35, 40, Colors.red),
            ],
          ),
          AnimatedAlign(
            duration: Duration(milliseconds: 300),
            alignment: Alignment(_getAlignment(), 0),
            child: Container(
              width: 4,
              height: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment(double start, double end, Color color) {
    return Expanded(
      flex: ((end - start) * 10).toInt(),
      child: Container(color: color),
    );
  }
}

double calculateBMI(double height, double weight) {
  return weight / ((height / 100) * (height / 100));
}