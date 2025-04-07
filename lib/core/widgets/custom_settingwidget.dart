import 'package:flutter/material.dart';

class CustomSettingwidget extends StatelessWidget {
  const CustomSettingwidget({super.key,required this.title,required this.icon,
  required this.check,this.pageName});
  final String title;
  final IconData icon;
  final bool check;
  final String ?pageName;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
              title,
              ),
              horizontalTitleGap: 20,
              onTap: () {
                Navigator.pushNamed(context, pageName!);
              },
              leading: Icon(icon),
              trailing:check==1?Icon(Icons.chevron_right_outlined):Icon(Icons.chevron_right_outlined),
            )
          ],
        ),
      );
    
  }
}
