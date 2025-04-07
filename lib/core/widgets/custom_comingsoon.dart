import 'package:flutter/material.dart';

class CustomComingsoon extends StatelessWidget {
  const CustomComingsoon({super.key,required this.title,required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            image,
          fit: BoxFit.fill,
          ),
          Center(
            child: Container(
              width: double.infinity,
              height:120,
              color: const Color(0xFF0095FF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Coming Soon',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
