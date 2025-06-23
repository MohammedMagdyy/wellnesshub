import 'package:flutter/material.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/services/auth/facebook_login.dart';
import 'package:wellnesshub/core/services/auth/google_login.dart';
import 'package:wellnesshub/core/utils/appimages.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_listtile.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import '../../core/helper_class/accesstoken_storage.dart';
import '../../core/helper_functions/build_customSnackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../core/services/auth/login_service.dart';
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
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: formkey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: ListView(
                  children: [
                    SizedBox(height: screenHeight * 0.08),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Wellness Hub',
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                              color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            'it’s good to see you again',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: isDark? darkSecondaryTextColor : lightSecondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.095),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: CustomTextField(
                        name: "Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => email = value.toLowerCase(),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: CustomTextField(
                        name: "Password",
                        obscureText: true,
                        onChanged: (value) => password = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, FindYourAccount.routeName);
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(color: isDark? darkPrimaryTextColor : lightPrimaryTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth
                              * 0.04, vertical: screenHeight * 0.01),
                      child: CustomButton(
                        color: Colors.white,
                        width: double.infinity,
                        name: 'Sign In',
                        on_Pressed: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            try {
                              print(password);
                              print("email");
                              final result =
                              await LoginService().login(email, password);
                              if (result['success']) {
                                final token =
                                await LocalStorageAccessToken.getToken();
                                //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                                debugPrint('Access token: $token');
                                final snackBar = buildCustomSnackbar(
                                  backgroundColor: Colors.greenAccent,
                                  title: 'Success!',
                                  message: result['message'],
                                  type: ContentType.success,
                                );
                                ScaffoldMessenger.of(context).
                                showSnackBar(snackBar);
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  'MainPage',
                                      (Route<dynamic> route) => false,
                                );

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
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 20,
                            endIndent: 10,
                            thickness: 1.5,
                            color: isDark? darkSecondaryTextColor:lightSecondaryTextColor,
                          ),
                        ),
                        Text(
                          "or continue with",
                          style: TextStyle(
                            color:isDark? darkPrimaryTextColor:lightPrimaryTextColor,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            indent: 10,
                            endIndent: 20,
                            thickness: 1.5,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
                      child: CustomListTile(
                        on_Pressed: () async {
                          try {
                            final googleLogin = GoogleLoginService();
                            await googleLogin.loginWithGoogle(context);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        text: "Sign In Using Google",
                        image: Assets.assetsImagesGoogleLogo,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
                      child: CustomListTile(
                        on_Pressed: () async {
                          try {
                            final fbLogin = FacebookLoginService();
                            await fbLogin.loginWithFacebook(context);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        text: "Sign In With Facebook",
                        image: Assets.assetsImagesFacebookLogo,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: isDark? darkSecondaryTextColor : lightSecondaryTextColor,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'SignUpPage');
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: isDark? darkPrimaryTextColor : lightPrimaryTextColor,
                              fontSize: screenWidth * 0.04,
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
