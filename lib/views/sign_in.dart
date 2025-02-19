import 'package:flutter/material.dart';

import 'package:wellnesshub/widgets/custom_button.dart';
import 'package:wellnesshub/widgets/custom_textfield.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool _isLoading = false;
  String? Email;

  String? Password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                        style: TextStyle(fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text(
                        'it’s good to see you again',
                        style: TextStyle(fontSize: 15),
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
                      Email = value;
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextfield(
                    name: "Password",
                    onChanged: (value) {
                      Password = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:8),
                  child: CustomButton(
                    name: 'Sign In',
                    on_Pressed: () async {
                      if (formkey.currentState!.validate()) {
                        _isLoading = true;
                        setState(() {});
                        //await SignIn_Func();
                        //  Show_SnakBar(context, "Success");
                        // Navigator.pushNamed(context, Chatpage.routeName);
                      }
                      ;
                    },
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 10,
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    Text("or continue with"),
                    Expanded(
                      child: Divider(
                        indent: 10,
                        endIndent: 20,
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:8),
                  child: CustomButton(
                    name: 'Sign In With Google',
                    on_Pressed: () async {
                      if (formkey.currentState!.validate()) {
                        _isLoading = true;
                        setState(() {});
                        //await SignIn_Func();
                        //  Show_SnakBar(context, "Success");
                        // Navigator.pushNamed(context, Chatpage.routeName);
                      }
                      ;
                    },
                  ),
                ),
                SizedBox(height: 16,),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'SignUpPage');
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
        ));
  }
}
