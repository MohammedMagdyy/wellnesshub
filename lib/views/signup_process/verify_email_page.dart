import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:wellnesshub/constant_colors.dart';
import 'package:wellnesshub/core/widgets/custom_appbar.dart';
import '../../core/services/auth/send_otp.dart';
import '../../core/services/auth/signup_service.dart';
import '../../core/utils/global_var.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});
  static const routeName = 'VerifyEmailPage';

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _timerEnd = false;
  String _otpCode = '';
  int _resendAttempts = 0;
  late DateTime _timerEndTime;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _timerEndTime = DateTime.now().add(const Duration(seconds: 45));
    _requestOTP();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _requestOTP() async {
    if (_resendAttempts >= 3) {
      setState(() {
        _errorMessage = 'Maximum resend attempts reached. Please try again later.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _timerEndTime = DateTime.now().add(const Duration(seconds: 45));
    });

    try {
      final userDataEmail = await storage.getUserEmail();
      final userData = await storage.getUserData();
      final email = userDataEmail;
      final fname = userData['fname'];
      final lname = userData['lname'];
      final username = '$fname $lname';

      if (email == null || username.isEmpty) {
        throw Exception('User data not found');
      }

      final OTP otpService = OTP();
      final response = await otpService.activeOtp(email: email, username: username);

      setState(() {
        _otpCode = response['otp']?.toString() ?? '';
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@");
        print(_otpCode);
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@");
        _timerEndTime = DateTime.now().add(const Duration(seconds: 45));
        _timerEnd = false;
        _resendAttempts++;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to send OTP. Please try again.';
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
    }
  }

  void _verifyOTP() {
    if (_isLoading) return;

    final enteredOtp = _pinController.text.trim();

    if (enteredOtp.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter the OTP';
      });
      return;
    }

    if (enteredOtp.length != 6) {
      setState(() {
        _errorMessage = 'OTP must be 6 digits';
      });
      return;
    }

    if (_otpCode.isEmpty) {
      setState(() {
        _errorMessage = 'No OTP requested. Please request a new OTP.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 500), () async {
      if (enteredOtp == _otpCode) {
        try {
          final userinfoEmail = await storage.getUserEmail();
          final userinfo = await storage.getUserData();
          if (userinfoEmail == null || userinfo['password'] == null) {
            throw Exception('User credentials not found in local storage');
          }

          final signupService = SignupService();
          final signupResult = await signupService.signup(
            userinfo['fname']!,
            userinfo['lname']!,
            userinfoEmail!,
            userinfo['password']!,
          );

          if (signupResult['success'] == true) {
            print("@@@@@@@@@@@OK@@@@@@@@@@@@@@@@@@@");
          } else {
            // Show error message to user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(signupResult['message'] ?? 'Signup failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }catch(e){
          print(e.toString());
        }

        Navigator.pushReplacementNamed(context, 'AgePage');
      } else {
        setState(() {
          _errorMessage = 'Invalid OTP. Please try again.';
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP entered')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultPinTheme = PinTheme(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(70, 189, 189, 200),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xff80C9FC)),
      ),
    );

    return Scaffold(
      appBar: CustomAppbar(title: 'Email Verification'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
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
                "Enter the 6-digit OTP sent to your email",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // OTP Input Field
              Pinput(
                controller: _pinController,
                focusNode: _focusNode,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  ),
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  }
                  if (value.length != 6) {
                    return 'OTP must be 6 digits';
                  }
                  return null;
                },
                onCompleted: (value) => _verifyOTP(),
                showCursor: true,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                onTapOutside: (_) => _focusNode.unfocus(),
              ),

              // Error message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 30),

              // Timer
              TimerCountdown(
                endTime: _timerEndTime,
                enableDescriptions: false,
                format: CountDownTimerFormat.minutesSeconds,
                timeTextStyle: const TextStyle(color: Color(0xff80C9FC)),
                onEnd: () {
                  setState(() {
                    _timerEnd = true;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive OTP?", style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _timerEnd ? _requestOTP : null,
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        color: _timerEnd ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Verify Button
              ElevatedButton(
                onPressed: _verifyOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Verify",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


