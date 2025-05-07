import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/helper_functions/build_customSnackbar.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import '../../core/utils/global_var.dart';
import 'package:bcrypt/bcrypt.dart';




class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const routeName = 'SignUpPage';

  @override
  State<SignUp> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool _isLoading = false;
  // ignore: non_constant_identifier_names
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "SignUp"),
      body: Form(
        key: formkey,
        child: SafeArea(
          child: ListView(
            children: [
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
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  name: "First Name",
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  name: "Last Name",
                  onChanged: (value) {
                    lastName = value;
                  },
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  name: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  obscureText: true,
                  name: "Password",
                  onChanged: (value) {
                    password = value;
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  obscureText: true,
                  name: "Confirm Password",
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: CustomButton(
                  color: Colors.white,
                  width: double.infinity,
                  name: 'Sign Up',
                    on_Pressed: () async {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        if (!email!.contains('@')) {
                          final snackBar = buildCustomSnackbar(
                            backgroundColor: Colors.redAccent,
                            title: 'Oops!',
                            message: 'Please enter a valid email address.',
                            type: ContentType.failure,
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }

                        if (password == null || password!.length < 8) {
                          final snackBar = buildCustomSnackbar(
                            backgroundColor: Colors.redAccent,
                            title: 'Oops!',
                            message: 'Password must be at least 8 characters long',
                            type: ContentType.failure,
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }

                        if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{8,}$').hasMatch(
                            password!)) {
                          final snackBar = buildCustomSnackbar(
                            backgroundColor: Colors.amberAccent,
                            title: 'Oops!',
                            message: 'Password must contain at least one digit and one letter',
                            type: ContentType.warning,
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }

                        if (password != confirmPassword) {
                          final snackBar = buildCustomSnackbar(
                            backgroundColor: Colors.redAccent,
                            title: 'Oops!',
                            message: 'Passwords don\'t match',
                            type: ContentType.failure,
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }

                        //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                        String hashedPassword = BCrypt.hashpw(password!, BCrypt.gensalt());
                        await storage.saveUserData(email:email!,fname: firstName!,
                              lname:  lastName!,password:hashedPassword);
                        Navigator.pushNamed(
                            context, 'VerifyEmailPage');
                        // try {
                        //   SignupService signupService = SignupService();
                        //   final result = await signupService.signup(
                        //       firstName!, lastName!, email!, password!);
                        //
                        //   if (result['success'] == true && email != null) {
                        //
                        //     await storage.saveUserData(email:email!,fname: firstName!,
                        //        lname:  lastName!,password:password!);
                        //
                        //
                        //     Navigator.pushNamed(
                        //         context, 'VerifyEmailPage');
                        //   } else {
                        //     final snackBar = buildCustomSnackbar(
                        //       backgroundColor: Colors.redAccent,
                        //       title: 'Oops!',
                        //       message: result['message'],
                        //       type: ContentType.failure,
                        //     );
                        //     ScaffoldMessenger.of(context)
                        //       ..hideCurrentSnackBar()
                        //       ..showSnackBar(snackBar);
                        //   }
                        // } catch (e) {
                        //   final snackBar = buildCustomSnackbar(
                        //     backgroundColor: Colors.redAccent,
                        //     title: 'Error!',
                        //     message: 'An unexpected error occurred.',
                        //     type: ContentType.failure,
                        //   );
                        //   ScaffoldMessenger.of(context)
                        //     ..hideCurrentSnackBar()
                        //     ..showSnackBar(snackBar);
                        // } finally {
                        //   setState(() {
                        //     _isLoading = false;
                        //   });
                        // }
                      }
                    }

                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'LoginPage');
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
      ),
    );
  }
}
