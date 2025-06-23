import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/helper_functions/showLanguagePicker.dart';
import 'package:wellnesshub/core/helper_functions/show_fontsize_Picker.dart';
import 'package:wellnesshub/core/widgets/custom_switchtoggle.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'package:wellnesshub/views/login_process/sign_in.dart';

import '../services/auth/delete_account.dart';

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

  void _showConfirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      content,
                      textAlign: TextAlign.center,
                    ),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), // Cancel
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          onConfirm(); // Execute confirmation logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          color: isDark? darkSettingsButtonColor : lightSettingsButtonColor,
          border: Border(
            bottom: BorderSide(color: isDark?darkSettingsArrowsColor:lightSettingsArrowsColor, width: 1),
            left: BorderSide(color: isDark?darkSettingsArrowsColor:lightSettingsArrowsColor, width: 1),
            right: BorderSide(color: isDark?darkSettingsArrowsColor:lightSettingsArrowsColor, width: 1),
            top: BorderSide(color: isDark?darkSettingsArrowsColor:lightSettingsArrowsColor, width: 1),
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: isDark? darkBoxShadowColor : lightBoxShadowColor,
              offset: Offset(3, 3),
              blurRadius: 6,
              spreadRadius: 1,
            )
          ]
        ),
        child: ListTile(
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark? darkSettingsBtnTextColor : lightSettingsBtnTextColor,
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
              //logout Confirmation
              _showConfirmationDialog(
                title: "Confirm Logout",
                content: "Are you sure you want to log out?",
                onConfirm: () {
                  Navigator.pushReplacementNamed(context,SignInPage.routeName);
                },
              );
            }
            else if(widget.onTapFunc == 4){
              _showConfirmationDialog(
                title: "Delete Account",
                content: "Are you sure you want to delete your account? This action is irreversible.",
                onConfirm: () async{
                  DeleteAccountService deleteAccountService = DeleteAccountService();
                  final response=await deleteAccountService.deleteAccount();
                 try{
                   if(response['success']){
                     Navigator.pushReplacementNamed(context,SignInPage.routeName);
                   }
                   else{
                     print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR");
                     ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(response['message']),
                           backgroundColor: Colors.red,
                         ),
                     );
                     }
                 }catch(e){
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text(e.toString()),
                       backgroundColor: Colors.red,
                     ),);
                     }

                },
              );

            }
            else if(widget.onTapFunc == 5){

            }
          },
          leading: Icon(
            widget.icon,
            color: isDark? darkSettingsBtnTextColor : lightSettingsBtnTextColor,
          ),
          trailing: widget.switchcheck
              ? CustomToggleSwitch(
                isDarkModeSwitch: widget.isDarkModeSwitch,
              )
              : Icon(
                  Icons.chevron_right_outlined,
                  color: isDark? darkSettingsArrowsColor : lightSettingsArrowsColor,
                ),
        ),
      ),
    );
  }
}
