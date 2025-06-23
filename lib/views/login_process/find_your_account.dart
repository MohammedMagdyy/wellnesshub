import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/utils/global_var.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:wellnesshub/views/login_process/restorepassword_otp.dart';
import '../../core/helper_functions/build_customSnackbar.dart';
import '../../core/services/auth/restorepassword_otp_service.dart';

class FindYourAccount extends StatefulWidget {
  const FindYourAccount({super.key});
  static const String routeName = 'FindYourAccount';

  @override
  State<FindYourAccount> createState() => _FindYourAccountState();
}

class _FindYourAccountState extends State<FindYourAccount> {
  String? email;
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (email == null || email!.isEmpty || !email!.contains('@')) {
      final snackBar = buildCustomSnackbar(
        backgroundColor: Colors.orange,
        title: 'Invalid Email',
        message: 'Please enter a valid email address.',
        type: ContentType.warning,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    try {
      setState(() => _isLoading = true);

      // Check with server
      final response = await RestorePasswordService().restorePassword(email!);

      if (response['success']) {
        GlobalVar().saveEmailForRestoredPassword(email!);
        Navigator.pushNamed(context, RestorePasswordOtp.routeName);
      } else {
        final snackBar = buildCustomSnackbar(
          backgroundColor: Colors.red,
          title: 'Error',
          message: response['message'] ?? 'Something went wrong',
          type: ContentType.failure,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = buildCustomSnackbar(
        backgroundColor: Colors.red,
        title: 'Error!',
        message: 'Could not complete the request. Please try again.',
        type: ContentType.failure,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(title: "Find Your Account"),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Please enter your email address to search for your account.",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                      color: isDark? darkPrimaryTextColor : lightPrimaryTextColor
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      name: "Enter Email Address",
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    const SizedBox(height: 30),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      name: "Search",
                      width: 180,
                      color: Colors.white,
                      on_Pressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
