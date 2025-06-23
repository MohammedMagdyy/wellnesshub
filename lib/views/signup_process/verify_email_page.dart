import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:wellnesshub/constant_colors.dart';
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
      // Assuming the response is a map, you will now extract the OTP correctly
      Map<String, dynamic> response = await otp.activeOtp(email: email! , username:  username!);
      setState(() {
        // Extract OTP from the response map (assuming the OTP key is 'otp')
        otp_code = response['otp'] ?? '';  // Default to empty string if 'otp' key doesn't exist
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
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(pinController.text);
    if (pinController.text == otp_code && otp_code != ''){
      Navigator.pushReplacementNamed(context, 'AgePage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP entered.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppbar(title: 'Email Verification'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Email Verification",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
                color: isDark? darkPrimaryTextColor:lightPrimaryTextColor
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Enter the OTP sent to your email inbox",
              style: TextStyle(fontSize: 16,
                  color: isDark? darkSecondaryTextColor : lightSecondaryTextColor
              ),
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
                  color: isDark? darkCardColor : lightCardColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: isDark? darkCardBorderColor:lightCardBorderColor),
                ),
              ),
              submittedPinTheme: PinTheme(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: isDark? darkCardColor : lightCardColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color.fromARGB(255, 32, 255, 32)),
                ),
              ),
              focusedPinTheme: PinTheme(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: isDark? darkChatInputBarFocusedBorderColor: lightChatInputBarFocusedBorderColor),
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
              timeTextStyle: TextStyle(color: isDark? darkSecondaryTextColor : lightSecondaryTextColor),
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
                Text("Didn't receive OTP?", style: TextStyle(color: isDark? darkSecondaryTextColor : lightSecondaryTextColor)),
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
                    style: TextStyle(color: isDark? darkBmiTextColor_1:lightBmiTextColor_1),
                  ),
                )
                    : Text("Resend OTP", style: TextStyle(color: isDark?darkBmiTextColor_3 : lightBmiTextColor_3 )),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _submitOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark? darkImportantButtonEnd:lightImportantButtonEnd,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text(
                "Verify",
                style: TextStyle(color: isDark? darkButtonTextColor : lightButtonTextColor, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
