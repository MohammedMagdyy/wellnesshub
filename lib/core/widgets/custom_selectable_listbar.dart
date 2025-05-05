import 'package:flutter/material.dart';

class CustomSelectableListBar extends StatefulWidget {
  final String title;
  final int totalIndex;
  final Function(int) onSelected;
  final int initialSelectedIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final Color textColor;
  final Color selectedTextColor;
  final Duration animationDuration;

  const CustomSelectableListBar({
    super.key,
    required this.title,
    required this.totalIndex,
    required this.onSelected,
    this.initialSelectedIndex = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.transparent,
    this.textColor = Colors.blue,
    this.selectedTextColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<CustomSelectableListBar> createState() => _CustomSelectableListBarState();
}

class _CustomSelectableListBarState extends State<CustomSelectableListBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.totalIndex, (index) {
          final isSelected = selectedIndex == index;
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onSelected(index);
            },
            child: AnimatedContainer(
              duration: widget.animationDuration,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? widget.selectedColor : widget.unselectedColor,
                border: Border.all(color: widget.selectedColor, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "${widget.title} ${index + 1}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? widget.selectedTextColor : widget.textColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
