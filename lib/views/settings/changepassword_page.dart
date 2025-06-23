import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import '../../core/helper_functions/build_customSnackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../core/services/auth/change_password_service.dart';
import '../../core/utils/global_var.dart';
import '../login_process/sign_in.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key});
  static const String routeName = 'ChangePasswordPage';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(title: "Change Password"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Spacer(flex: 6),
              Text(
                "Change Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                color: isDark?darkPrimaryTextColor: lightPrimaryTextColor
                ),
              ),
              Spacer(flex: 3),
              CustomTextField(
                name: "Enter Current Password",
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {
                  setState(() {
                    currentPassword = value;
                  });
                },
              ),
              Spacer(flex: 1),
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
              Spacer(flex: 1),
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
              Spacer(flex: 1),
              CustomButton(
                name: "Update",
                width: 180,
                color: isDark? darkButtonTextColor : lightButtonTextColor,
                on_Pressed: _handlePasswordUpdate,
              ),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePasswordUpdate() async {
    setState(() => _isLoading = true);
    print("newPassword: '$newPassword'");
    print("length: ${newPassword?.length}");
    print("match regex: ${RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{8,}$').hasMatch(newPassword!)}");

    print(newPassword);
    print(currentPassword);
    if (currentPassword == null || currentPassword!.length < 8) {
      _showSnackbar(
        title: 'Oops!',
        message: 'Current password must be at least 8 characters long',
        color: Colors.redAccent,
        type: ContentType.failure,
      );
      setState(() => _isLoading = false);
      return;
    }

    if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{8,}$').hasMatch(newPassword!)) {

      _showSnackbar(
        title: 'Oops!',
        message: 'Current password must contain at least one digit and one letter',
        color: Colors.amberAccent,
        type: ContentType.warning,
      );
      setState(() => _isLoading = false);
      return;
    }

    if (newPassword == null || newPassword!.length < 8) {
      _showSnackbar(
        title: 'Oops!',
        message: 'New password must be at least 8 characters long',
        color: Colors.redAccent,
        type: ContentType.failure,
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

      if (result['success']) {
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
