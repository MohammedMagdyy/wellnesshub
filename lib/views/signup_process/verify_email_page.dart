import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});
  static const routeName = 'VerifyEmailPage';

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  bool timerEnd = false ;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email Verification",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ) ,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter the OTP sent to your email inbox",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 80,),
          Pinput(
            controller: pinController,
            focusNode: focusNode,
            defaultPinTheme: PinTheme(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(70, 189, 189, 200),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff80C9FC))
              ),
            ),
            closeKeyboardWhenCompleted: true,
            errorPinTheme: PinTheme(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.redAccent)
              ),
            ),
            errorText: "invalid OTP",
            errorTextStyle: TextStyle(
              color: Colors.red,
              fontSize: 10
            ),
            focusedPinTheme: PinTheme(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff80C9FC))
              ),
            ),
            length: 5,
            submittedPinTheme: PinTheme(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(70, 189, 189, 200),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color.fromARGB(255, 32, 255, 32))
              )
            ),
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            onTapOutside: (event) {
              focusNode.unfocus();
            },
            scrollPadding: EdgeInsets.all(10),
            showCursor: false,
            validator: (value) {
              return value == "11111" ? null : "";
            },
            onCompleted: (value) {
              print("completed");
            },

          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Text(
                "Resend OTP in  "
              ),
              TimerCountdown(
                endTime: DateTime.now().add(Duration(
                  minutes: 1
                )),
                enableDescriptions: false,
                format: CountDownTimerFormat.minutesSeconds,
                timeTextStyle: TextStyle(
                  color: Color(0xff80C9FC)
                ),
                onEnd: () {
                  setState(() {
                  timerEnd = true ;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20,),
              Text(
                "Didn't receive OTP ?",
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              SizedBox(width: 10,),
              timerEnd?
              InkWell(
                onTap: () {
                  //Active


                  
                },
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                    color: Colors.blue
                  ),
                ),
              ) :
              Text(
                "Resend OTP",
                style: TextStyle(
                  color: Colors.grey
                ),
              ) ,
            ],
          )
        ],
      ),
    );
  }
}