import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../../core/services/auth/restorepassword_otp_service.dart';
import '../../core/utils/global_var.dart';

class RestorePasswordOtp extends StatefulWidget {
  const RestorePasswordOtp({super.key});
  static const routeName = 'RestorePasswordOtp';

  @override
  State<RestorePasswordOtp> createState() => _RestorePasswordOtpState();
}

class _RestorePasswordOtpState extends State<RestorePasswordOtp> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool timerEnd = false;
  String otp_code = '';
  String? email;
  late DateTime timerEndTime;
  bool _isVerifying = false;

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
    GlobalVar globalVar = GlobalVar();
    email = await globalVar.getEmailForRestoredPassword();

    try {
      RestorePasswordService restorePasswordService = RestorePasswordService();
      Map<String, dynamic> response = await restorePasswordService.restorePassword(email!);
      setState(() {
        // Extract OTP from the response map
        otp_code = response['otp'] ?? '';  // Ensure you have a default value if the OTP key is missing
        print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        print(response);
        print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        timerEndTime = DateTime.now().add(const Duration(seconds: 45));
        timerEnd = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP has been resent.")),
      );
      print("OTP received: $otp_code");
    } catch (e) {
      print("Error receiving OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to receive OTP. Try again.")),
      );
    }
  }


  void _submitOtp() {
    setState(() {
      _isVerifying = true;
    });

    if (pinController.text == otp_code && otp_code != '') {
      Navigator.pushReplacementNamed(context, 'ForgetPasswordPage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP entered.")),
      );
    }

    setState(() {
      _isVerifying = false;
    });
  }

  String maskEmail(String? email) {
    if (email == null || !email.contains("@")) return "";
    final parts = email.split("@");
    final prefix = parts[0].substring(0, 2);
    return "$prefix***@${parts[1]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Email Verification'),
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
            Text(
              "Enter the OTP sent to your email inbox ${maskEmail(email)}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                      pinController.clear();
                      _receiveOTP();
                    }
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
                    : const Text("Resend OTP", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 50),
            _isVerifying
                ? const CircularProgressIndicator()
                : ElevatedButton(
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
