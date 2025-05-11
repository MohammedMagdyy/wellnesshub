import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:wellnesshub/views/login_process/sign_in.dart';
import '../../core/helper_functions/build_customSnackbar.dart';
import '../../core/services/auth/change_password_service.dart';
import '../../core/utils/global_var.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  static const String routeName = 'ForgetPasswordPage';

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
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
              const Spacer(flex: 6),
              const Text(
                "Change Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 3),
              CustomTextField(
                name: "Enter New Password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) => setState(() => newPassword = value),
              ),
              const Spacer(flex: 1),
              CustomTextField(
                name: "Confirm New Password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) => setState(() => confirmPassword = value),
              ),
              const Spacer(flex: 1),
              CustomButton(
                name: _isLoading ? "Updating..." : "Update",
                width: 180,
                color: Colors.white,
                on_Pressed: _isLoading ? null : _handlePasswordUpdate,
              ),
              const Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePasswordUpdate() async {
    setState(() => _isLoading = true);

    if (newPassword == null || newPassword!.length < 8) {
      _showSnackbar(
        title: 'Oops!',
        message: 'Password must be at least 8 characters long',
        color: Colors.redAccent,
        type: ContentType.failure,
      );
      setState(() => _isLoading = false);
      return;
    }

    if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{8,}$').hasMatch(newPassword!)) {
      _showSnackbar(
        title: 'Oops!',
        message: 'Password must contain at least one digit and one letter',
        color: Colors.amberAccent,
        type: ContentType.warning,
      );
      setState(() => _isLoading = false);
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackbar(
        title: 'Oops!',
        message: 'Passwords don\'t match',
        color: Colors.redAccent,
        type: ContentType.failure,
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      final email = await GlobalVar().getEmailForRestoredPassword();

      final result = await ChangePasswordService()
          .changePasswordForRestoreAccount(email!, confirmPassword!);
      print(result);
      if (result['success']) {
        print("Successsssssssssssssssss");
        _showSnackbar(
          title: 'Success!',
          message: result['message'],
          color: Colors.greenAccent,
          type: ContentType.success,
        );

         Navigator.pushReplacementNamed(context, SignInPage.routeName);
      }
    } on DioException catch (e) {
      _showSnackbar(
        title: 'Error!',
        message: e.response?.data['message'] ?? 'Error changing password',
        color: Colors.redAccent,
        type: ContentType.failure,
      );
    } catch (_) {
      _showSnackbar(
        title: 'Error!',
        message: 'Something went wrong. Please try again.',
        color: Colors.redAccent,
        type: ContentType.failure,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackbar({
    required String title,
    required String message,
    required Color color,
    required ContentType type,
  }) {
    final snackBar = buildCustomSnackbar(
      backgroundColor: color,
      title: title,
      message: message,
      type: type,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
