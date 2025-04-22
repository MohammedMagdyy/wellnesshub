import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';

class ChangepasswordPage extends StatelessWidget {
  ChangepasswordPage({super.key});
  static const String routeName = 'ChangepasswordPage';
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Change Password"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Spacer(
              flex: 6,
            ),
            Text(
              "Change Password",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 3,
            ),
            CustomTextfield(
              name: "Enter Current Password",
              obscureText: true,
              keyboardtype: TextInputType.visiblePassword,
              onChanged: (value) {
                currentPassword = value;
              },
            ),
            Spacer(
              flex: 1,
            ),
            CustomTextfield(
              name: "Enter New Password",
              obscureText: true,
              keyboardtype: TextInputType.visiblePassword,
              onChanged: (value) {
                newPassword = value;
              },
            ),
            Spacer(
              flex: 1,
            ),
            CustomTextfield(
              name: "Confirm New Password",
              obscureText: true,
              keyboardtype: TextInputType.visiblePassword,
              onChanged: (value) {
                confirmPassword = value;
              },
            ),
            Spacer(
              flex: 1,
            ),
            CustomButton(
              name: "Update",
              width: 180,
              color: Colors.white,
              on_Pressed: () {},
            ),
            Spacer(
              flex: 6,
            ),
          ],
        ),
      )),
    );
  }
}
