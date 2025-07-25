import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/global_var.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({
    super.key ,
    required this.isDarkModeSwitch,
    });
  static const routeName = 'CustomToggleSwitch';
  final bool isDarkModeSwitch ;
  

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    isToggled = GlobalVar().isDarkModeNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Switch(
      value: isToggled,
      onChanged: (value)async {
        
          if(widget.isDarkModeSwitch){
            await GlobalVar().toggleDarkMode();
            print(GlobalVar().isDarkModeNotifier.value);
          }
          else {
            // implement the notification
          }

        setState((){
          isToggled = value;
        });
      },
      activeColor: isDark? darkSwitchThumbOnColor : lightSwitchThumbOnColor, // Thumb color when ON
      activeTrackColor: isDark? darkSwitchTrackOnColor : lightSwitchTrackOnColor, // Track color when ON
      inactiveThumbColor: isDark? darkSwitchThumbOffColor : lightSwitchThumbOffColor, // Thumb color when OFF
      inactiveTrackColor: isDark? darkSwitchTrackOffColor : lightSwitchTrackOffColor, // Track color when OFF
    );
  }
}
