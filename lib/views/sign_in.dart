import 'package:flutter/material.dart';
import 'package:wellnesshub/core/services/auth/facebook_login.dart';
import 'package:wellnesshub/core/services/auth/google_login.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_listtile.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const routeName = 'LoginPage';

  @override
  State<SignInPage> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  final GlobalKey<FormState> formkey = GlobalKey();
  bool _isLoading = false;
  String email = "";
  String password = "";
  String? error;

  bool _isFacebookLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: formkey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 60),
                    const Padding(
                      padding: EdgeInsets.all(48.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Wellness Hub ',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0065d0),
                            ),
                          ),
                          Text(
                            'it’s good to see you again',
                            style: TextStyle(
                                fontSize: 15, color: Color(0xff0065d0)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextfield(
                        name: "Email",
                        keyboardtype: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextfield(
                        name: "Password",
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              color: Colors.white,
                              width: double.infinity,
                              name: 'Sign In',
                              on_Pressed: () async {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  //   LoginService loginservice = LoginService();
                                  //   final success = await loginservice.login(email, password);
                                  //   if (success) {
                                  //     Navigator.pushReplacementNamed(context, 'MainPage');
                                  //   } else {
                                  //     setState(
                                  //       () {
                                  //         error =
                                  //             'Login failed. Please check your credentials.';
                                  //       },
                                  //     );
                                  //   }
                                  // }
                                  // Simulate login delay or call real login service
                                  await Future.delayed(
                                      const Duration(milliseconds: 300));
                                  Navigator.pushReplacementNamed(
                                      context, 'MainPage');
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                            ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Expanded(
                            child: Divider(
                              indent: 20,
                              endIndent: 10,
                              thickness: 1.5,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            "or continue with",
                            style: TextStyle(color: Color(0xff0065d0)),
                          ),
                          Expanded(
                            child: Divider(
                              indent: 10,
                              endIndent: 20,
                              thickness: 1.5,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ]),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: CustomListTile(
                        on_Pressed: () async {
                          try {
                            final googleLogin = GoogleLoginService();
                            await googleLogin.loginWithGoogle(context);
                          } catch (e, stack) {
                            debugPrint('❌ Google login error: $e');
                            debugPrint('📌 Stack trace: $stack');
                          }
                        },
                        text: "Sign In Using Google",
                        image: Assets.assetsImagesGoogleLogo,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: CustomListTile(
                        on_Pressed: () async {
                          try {
                            final fbLogin = FacebookLoginService();
                            await fbLogin.loginWithFacebook(context);
                          } catch (e, stack) {
                            debugPrint('❌ Facebook login error: $e');
                            debugPrint('📌 Stack trace: $stack');
                          }
                        },
                        text: "Sign In With Facebook",
                        image: Assets.assetsImagesFacebookLogo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Color(0xff0065d0),
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'SignUpPage');
                          },
                          child: const Text(
                            "Sign Up",
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
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
