import 'package:flutter/material.dart';

class CustomGendericon extends StatelessWidget {
  const CustomGendericon({super.key,required this.imagee,required this.firstColor,required this.spalshColor});
  final String imagee;
  final Color firstColor;
  final Color spalshColor;

  @override
  Widget build(BuildContext context) {
    return Material(
                    color: firstColor, // Make the background visible for splash effect
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      splashColor:spalshColor.withOpacity(0.5), // Visible red effect on tap
                      onTap: () {
                        // Add action here
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: AssetImage(imagee),
                            
                          ),
                        ),
                      ),
                    ),
                  );
  }
}
