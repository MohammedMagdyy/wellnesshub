import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              size: screenWidth * 0.07,
              color: Colors.white,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, Madison",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: const Color(0xff0095FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Let's make your body stronger today!",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: const Color(0xff0095FF),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "Profile");
            },
            child: Icon(
              Icons.person,
              size: screenWidth * 0.065,
              color: const Color(0xff0095FF),
            ),
          ),
        ],
      ),
    );
  }
}
