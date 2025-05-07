import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../core/helper_functions/build_customSnackbar.dart';
import 'find_your_account.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({super.key});
  static const String routeName = 'ForgetPasswordPage';

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Forget Password"),
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
                CustomTextField(

                  name: "Enter New Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      newPassword = value;
                    });
                  },
                ),
                Spacer(
                  flex: 1,
                ),
                CustomTextField(

                  name: "Confirm New Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      confirmPassword = value;
                    });
                  },
                ),
                Spacer(
                  flex: 1,
                ),
                CustomButton(
                  name: "Update",
                  width: 180,
                  color: Colors.white,
                  on_Pressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    if (newPassword == null || newPassword!.length < 8) {
                      final snackBar = buildCustomSnackbar(
                        backgroundColor: Colors.redAccent,
                        title: 'Oops!',
                        message: 'Password must be at least 8 characters long',
                        type: ContentType.failure,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      setState(() {
                        _isLoading = false;
                      });
                      return;
                    }

                    if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{8,}$')
                        .hasMatch(newPassword!)) {
                      final snackBar = buildCustomSnackbar(
                        backgroundColor: Colors.amberAccent,
                        title: 'Oops!',
                        message:
                        'Password must contain at least one digit and one letter',
                        type: ContentType.warning,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      setState(() {
                        _isLoading = false;
                      });
                      return;
                    }
                    if (newPassword != confirmPassword) {
                      final snackBar = buildCustomSnackbar(
                        backgroundColor: Colors.redAccent,
                        title: 'Oops!',
                        message: 'Passwords don\'t match',
                        type: ContentType.failure,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      setState(() {
                        _isLoading = false;
                      });
                      return;
                    }
                    // Add your logic here for updating the password
                    // For example, you might call an API or update a local database
                    print("Password updated successfully");
                    setState(() {
                      _isLoading = false;
                    });
                   // Navigator.pushNamed(context, FindYourAccount.routeName);
                  },
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