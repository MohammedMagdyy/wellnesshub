import 'package:flutter/material.dart';
import 'package:wellnesshub/constant.dart';
import 'package:wellnesshub/widgets/custom_button.dart';
import 'package:wellnesshub/widgets/custom_textfield.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {

  bool _isLoading = false;
  String? FirstName;
  String? LastName;
  String? Email;
  String? Password;
  String? ConfirmPassword;

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
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          
                        ),
                        child: Text(
                          'Create an Account to Start your Healthy Life  ',
                          style: TextStyle(fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextfield(
                    name: "First Name",
                    onChanged: (value) {
                      FirstName = value;
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextfield(
                    name: "Last Name",
                    onChanged: (value) {
                      LastName = value;
                    },
                  ),
                ),
                const SizedBox(height: 18),
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
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextfield(
                    name: "Confirm Password",
                    onChanged: (value) {
                      ConfirmPassword = value;
                    },
                  ),
                ),
                
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:8),
                  child: CustomButton(
                    name: 'Sign Up',
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
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, SignUpPage.routeName);
                      },
                      // Navigate to Sign Up page
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));

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
          ),
        ),);;
  }
}