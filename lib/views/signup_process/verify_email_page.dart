import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../../core/helper_class/userInfo_local.dart';
import '../../core/services/auth/send_otp.dart';
import '../../core/utils/global_var.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});
  static const routeName = 'VerifyEmailPage';

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool timerEnd = false;
  String otp_code = '';
  late DateTime timerEndTime;

  @override
  void initState() {
    super.initState();
    timerEndTime = DateTime.now().add(const Duration(seconds: 45));
    _receiveOTP();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _receiveOTP() async {
    final userData = await storage.getUserData();
    String? email = userData['email'];
    String? fname = userData['fname'];
    String? lname = userData['lname'];
    String username = '$fname $lname';

    try {
      OTP otp = OTP();
      String response = await otp.activeOtp(email: email!, username: username);
      setState(() {
        otp_code = response;
        timerEndTime = DateTime.now().add(const Duration(seconds: 10));
        timerEnd = false;
      });
      print("OTP received: $otp_code");
    } catch (e) {
      print("Error receiving OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to receive OTP. Try again.")),
      );
    }
  }

  void _submitOtp() {
    if (pinController.text == otp_code) {
      Navigator.pushReplacementNamed(context, 'AgePage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP entered.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Email Verification'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Email Verification",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter the OTP sent to your email inbox",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Pinput(
              controller: pinController,
              focusNode: focusNode,
              length: 6,
              defaultPinTheme: PinTheme(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(70, 189, 189, 200),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xff80C9FC)),
                ),
              ),
              submittedPinTheme: PinTheme(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(70, 189, 189, 200),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color.fromARGB(255, 32, 255, 32)),
                ),
              ),
              focusedPinTheme: PinTheme(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xff80C9FC)),
                ),
              ),
              validator: (value) {
                return value == otp_code ? null : 'Invalid OTP';
              },
              onCompleted: (value) => _submitOtp(),
              showCursor: false,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              onTapOutside: (_) => focusNode.unfocus(),
            ),
            const SizedBox(height: 30),
            TimerCountdown(
              endTime: timerEndTime,
              enableDescriptions: false,
              format: CountDownTimerFormat.minutesSeconds,
              timeTextStyle: const TextStyle(color: Color(0xff80C9FC)),
              onEnd: () {
                setState(() {
                  pinController.clear();
                  timerEnd = true;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive OTP?", style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 10),
                timerEnd
                    ? GestureDetector(
                  onTap: () {
                    if (timerEnd) {
                      pinController.clear(); // Clear OTP input field
                      _receiveOTP();         // Get new OTP
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please wait for the timer to end before resending.")),
                      );
                    }
                  },
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(color: timerEnd ? Colors.blue : Colors.grey),
                  ),
                ): const Text("Resend OTP", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _submitOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text(
                "Verify",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
