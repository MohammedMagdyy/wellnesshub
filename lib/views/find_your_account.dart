import 'package:flutter/material.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import 'package:wellnesshub/core/widgets/custom_button.dart';
import 'package:wellnesshub/core/widgets/custom_textfield.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:wellnesshub/views/signup_process/verify_email_page.dart';
import '../core/helper_functions/build_customSnackbar.dart';

class FindYourAccount extends StatefulWidget {
  FindYourAccount({super.key});
  static const String routeName = 'FindYourAccount';

  @override
  State<FindYourAccount> createState() => _FindYourAccount();
}

class _FindYourAccount extends State<FindYourAccount> {
  String? email;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Find Your Account"),
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [

                        Text(
                          "Please enter your email address to search "
                              "for your account.",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height:20,
                        ),
                        CustomTextField(

                          name: "Enter Email Address",
                          obscureText: false,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),

                        SizedBox(
                          height:30,
                        ),
                        CustomButton(
                          name: "Search",
                          width: 180,
                          color: Colors.white,
                          on_Pressed: () {
                            setState(() {
                              _isLoading = true;
                            });

                            // Add your logic here for updating the password
                            // For example, you might call an API or update a local database
                            print("Password updated successfully");
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.pushNamed(context, VerifyEmailPage.routeName);
                          },
                        ),

                      ],
                    ),
                  )

              ),
            ),
          ),
      ),
    );
  }
}