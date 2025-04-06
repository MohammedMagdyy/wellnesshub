import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 30, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hi, Madison", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("It's time to challenge your limits.", style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
          ],
        ),
        const Spacer(),
        GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "Profile");
              },
          child: Icon(Icons.person, size: 28)),
      ],
    );
  }
}