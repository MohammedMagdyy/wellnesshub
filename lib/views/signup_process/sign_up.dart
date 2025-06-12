import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/helper_functions/build_customSnackbar.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import '../../core/services/auth/signup_service.dart';
import '../../core/utils/global_var.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const routeName = 'SignUpPage';

  @override
  State<SignUp> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool _isLoading = false;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar(title: "Sign Up"),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Form(
              key: formkey,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth < 600 ? 16 : screenWidth * 0.2,
                  vertical: 20,
                ),
                children: [
                  Center(
                    child: Text(
                      'Create an Account to Start your Healthy Life',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth < 400 ? 24 : 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 55),
                  CustomTextField(
                    name: "First Name",
                    onChanged: (value) => firstName = value,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    name: "Last Name",
                    onChanged: (value) => lastName = value,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    name: "Email",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => email = value,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    name: "Password",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => password = value,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    name: "Confirm Password",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) => confirmPassword = value,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50, // Match your button height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () async {
                        if (formkey.currentState!.validate()) {
                          setState(() => _isLoading = true);

                          try {
                            if (!email!.contains('@')) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(buildCustomSnackbar(
                                  backgroundColor: Colors.redAccent,
                                  title: 'Oops!',
                                  message: 'Please enter a valid email address.',
                                  type: ContentType.failure,
                                ));
                              setState(() => _isLoading = false);
                              return;
                            }

                            if (password == null || password!.length < 8) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(buildCustomSnackbar(
                                  backgroundColor: Colors.redAccent,
                                  title: 'Oops!',
                                  message: 'Password must be at least 8 characters long',
                                  type: ContentType.failure,
                                ));
                              setState(() => _isLoading = false);
                              return;
                            }

                            if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{8,}$').hasMatch(password!)) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(buildCustomSnackbar(
                                  backgroundColor: Colors.amberAccent,
                                  title: 'Oops!',
                                  message: 'Password must contain at least one digit and one letter',
                                  type: ContentType.warning,
                                ));
                              setState(() => _isLoading = false);
                              return;
                            }

                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(buildCustomSnackbar(
                                  backgroundColor: Colors.redAccent,
                                  title: 'Oops!',
                                  message: 'Passwords don\'t match',
                                  type: ContentType.failure,
                                ));
                              setState(() => _isLoading = false);
                              return;
                            }

                            await storage.saveUserData(
                              email: email!,
                              fname: firstName!,
                              lname: lastName!,
                              password: password!,
                            );

                            SignupService signupService = SignupService();
                            final signupResult = await signupService.signup(
                              firstName!,
                              lastName!,
                              email!,
                              password!,
                            );

                            if (!signupResult['success']) {
                              throw Exception(
                                  signupResult['message'] ?? 'Signup failed');
                            }

                            Navigator.pushNamed(context, 'VerifyEmailPage');
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(buildCustomSnackbar(
                                backgroundColor: Colors.redAccent,
                                title: 'Error!',
                                message: e.toString(),
                                type: ContentType.failure,
                              ));
                          } finally {
                            setState(() => _isLoading = false);
                          }
                        }
                      },
                      child: _isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 13, color: Colors.red),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'LoginPage');
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}