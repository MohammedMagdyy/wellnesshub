import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({super.key, required this.title});
  final String title;

  bool mainPages = false ;

  void toggle(){
    if(
      title == "Progress Tracker" ||
      title == "Favourites" ||
      title == "BMI Calculator"||
      title == "Settings"
    ){
      mainPages = true;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    toggle();

    if(mainPages){
      return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: isDark? darkAppbarTextColor : lightAppbarTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
    }
    else{
      return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? darkAppbarBackBkgnColor : lightAppbarBackBkgnColor,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: isDark ? darkAppbarBackBorderColor : lightAppbarBackBorderColor
            )
          ),
          child: IconButton(
            splashRadius: 24.0,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: isDark? darkAppbarBackArrowColor : lightAppbarBackArrowColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: isDark? darkAppbarTextColor : lightAppbarTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
    }
  }
}
