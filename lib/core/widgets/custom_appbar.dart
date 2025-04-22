import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(32),
          ),
          child: IconButton(
            splashRadius: 24.0,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff0095FF),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        'Page Title',
        style: TextStyle(
          color: Color(0xff0095FF),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}
