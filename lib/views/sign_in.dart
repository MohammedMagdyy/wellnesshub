import 'package:flutter/material.dart';
import 'package:wellnesshub/core/utils/appimages.dart';

import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_listtile.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static const routeName = 'LoginPage';

  @override
  State<SignIn> createState() => _Sign_InState();
}

class _Sign_InState extends State<SignIn> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool _isLoading = false;
  String email = "";
  String password = "";
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wellness Hub ',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0065d0),
                    ),
                  ),
                  Text(
                    'it’s good to see you again',
                    style:
                        TextStyle(fontSize: 15, color: const Color(0xff0065d0)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextfield(
                name: "Email",
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
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: CustomButton(
                color: Colors.white,
                width: double.infinity,
                name: 'Sign In',
                on_Pressed: () async {
                  if (formkey.currentState!.validate()) {
                    _isLoading = true;
                    setState(() {});
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
                    Navigator.pushReplacementNamed(context, 'MainPage');
                  }
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
                style: TextStyle(color: const Color(0xff0065d0)),
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
            SizedBox(
              height: 16,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: CustomListTile(
                text: "Sign In Using Google",
                image: Assets.assetsImagesGoogleLogo,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: CustomListTile(
                  text: "Sign In With Facebook",
                  image: Assets.assetsImagesFacebookLogo),
            ),
            SizedBox(
              height: 4,
            ),
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
                    //Navigator.pushNamed(context, SignUpPage.routeName);
                  },
                  // Navigate to Sign Up page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));

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
    );
  }
}
