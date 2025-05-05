import 'package:flutter/material.dart';
import 'package:wellnesshub/core/helper_functions/showLanguagePicker.dart';
import 'package:wellnesshub/core/helper_functions/show_fontsize_Picker.dart';
import 'package:wellnesshub/core/widgets/custom_switchtoggle.dart';
import 'package:wellnesshub/core/utils/global_var.dart';

class CustomSettingwidget extends StatefulWidget {
  const CustomSettingwidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.switchcheck,
      this.isDarkModeSwitch = false,
      this.onTapFunc = 0,
      required this.pageName,
      this.iconColor,
      this.textColor,
      });
  final String title;
  final IconData icon;
  final bool switchcheck;
  final bool isDarkModeSwitch;
  final String? pageName;
  final Color? textColor;
  final Color? iconColor;
  final int? onTapFunc;


  @override
  State<CustomSettingwidget> createState() => _CustomSettingwidgetState();
}

class _CustomSettingwidgetState extends State<CustomSettingwidget> {

  bool currentMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: isDark? Colors.black : Colors.white,
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
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark?Colors.white : Colors.black,
            ),
          ),
          horizontalTitleGap: 20,
          onTap: () {
            if (widget.onTapFunc == 0) {
              Navigator.pushNamed(context, widget.pageName!);
            } else if (widget.onTapFunc == 1) {
              showLanguagePicker(context);
            } else if (widget.onTapFunc == 2) {
              showFontSizePicker(context);
            } else if (widget.onTapFunc == 3){
              setState(() {
                
              });
            }
          },
          leading: Icon(
            widget.icon,
            color: Colors.blueAccent,
          ),
          trailing: widget.switchcheck
              ? CustomToggleSwitch(
                isDarkModeSwitch: widget.isDarkModeSwitch,
              )
              : Icon(
                  Icons.chevron_right_outlined,
                  color: widget.iconColor,
                ),
        ),
      ),
    );
  }
}
