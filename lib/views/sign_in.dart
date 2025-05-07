import 'package:flutter/material.dart';
import 'package:wellnesshub/core/services/auth/facebook_login.dart';
import 'package:wellnesshub/core/services/auth/google_login.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_listtile.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';

import '../core/helper_class/accesstoken_storage.dart';
import '../core/helper_functions/build_customSnackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../core/services/auth/login_service.dart';
import 'find_your_account.dart';

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
                      child: CustomTextField(
                        name: "Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextField(
                        name: "Password",
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              Navigator.pushNamed(context, FindYourAccount.routeName);
                            },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),),
                          ],
                        ),

                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: CustomButton(
                        color: Colors.white,
                        width: double.infinity,
                        name: 'Sign In',
                        on_Pressed: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            try {
                              final result = await LoginService().login(email, password);

                              if (result['success']) {
                                final token = await LocalStorageAccessToken.getToken();
                                debugPrint('Access token: $token');
                                Navigator.pushReplacementNamed(context, 'MainPage');
                              } else {
                                final snackBar = buildCustomSnackbar(
                                  backgroundColor: Colors.redAccent,
                                  title: 'Login Failed!',
                                  message: result['message'],
                                  type: ContentType.failure,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            } catch (e) {
                              final snackBar = buildCustomSnackbar(
                                backgroundColor: Colors.redAccent,
                                title: 'Error!',
                                message: 'Something went wrong. Please try again.',
                                type: ContentType.failure,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } finally {
                              setState(() => _isLoading = false);
                            }
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
                          } catch (e) {
                            print(e.toString());
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
                          } catch (e) {
                            print(e.toString());
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
