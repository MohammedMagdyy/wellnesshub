import 'package:flutter/material.dart';

class CustomSettingwidget extends StatelessWidget {
  const CustomSettingwidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.check,
      this.pageName,
      this.iconColor,
      this.textColor});
  final String title;
  final IconData icon;
  final bool check;
  final String? pageName;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.blue, width: 1),
            left: BorderSide(color: Colors.blue, width: 1),
            right: BorderSide(color: Colors.blue, width: 1),
            top: BorderSide(color: Colors.blue, width: 1),
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          horizontalTitleGap: 20,
          onTap: () {
            Navigator.pushNamed(context, pageName!);
          },
          leading: Icon(
            icon,
            color: Colors.blueAccent,
          ),
          trailing: check == 1
              ? Icon(
                  Icons.chevron_right_outlined,
                  color: iconColor,
                )
              : Icon(
                  Icons.chevron_right_outlined,
                  color: iconColor,
                ),
        ),
      ),
    );
  }
}
