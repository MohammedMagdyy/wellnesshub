import 'package:flutter/material.dart';

class CustomGenderIcon extends StatelessWidget {
  final String image;
  final Color firstColor;
  final Color selectedColor;
  final VoidCallback onTap;
  final bool isSelected;

  const CustomGenderIcon({
    Key? key,
    required this.image,
    required this.firstColor,
    required this.onTap,
    required this.selectedColor,
    required this.isSelected
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected ? selectedColor : firstColor,
          image: DecorationImage(
            image: AssetImage(image),
            
          ),
        ),
      ),
    );
  }
}
