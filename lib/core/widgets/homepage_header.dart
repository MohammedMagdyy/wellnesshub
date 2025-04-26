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
            const Text(
              "Hi, Madison",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff0095FF),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Let's make your body stronger today!",
              style: TextStyle(
                color: Color(0xff0095FF),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "Profile");
          },
          child: Icon(
            Icons.person,
            size: 28,
            color: Color(0xff0095FF),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
