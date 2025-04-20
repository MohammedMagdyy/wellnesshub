import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_functions/showLanguagePicker.dart';
import 'package:wellnesshub/core/helper_functions/show_fontsize_Picker.dart';
import 'package:wellnesshub/core/widgets/custom_switchtoggle.dart';

class CustomSettingwidget extends StatelessWidget {
  const CustomSettingwidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.switchcheck,
      this.onTapFunc = 0,
      required this.pageName,
      this.iconColor,
      this.textColor});
  final String title;
  final IconData icon;
  final bool switchcheck;
  final String? pageName;
  final Color? textColor;
  final Color? iconColor;
  final int? onTapFunc;

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
            if (onTapFunc == 0) {
              Navigator.pushNamed(context, pageName!);
            } else if (onTapFunc == 1) {
              showLanguagePicker(context);
            } else if (onTapFunc == 2) {
              showFontSizePicker(context);
            } else {
              //noThing
            }
          },
          leading: Icon(
            icon,
            color: Colors.blueAccent,
          ),
          trailing: switchcheck
              ? CustomToggleSwitch()
              : Icon(
                  Icons.chevron_right_outlined,
                  color: iconColor,
                ),
        ),
      ),
    );
  }
}
