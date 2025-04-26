
import 'package:flutter/material.dart';

class _InfoIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoIcon({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}