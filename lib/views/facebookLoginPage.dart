import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookLoginPage extends StatefulWidget {
  static const routeName = 'FacebookLoginPage';

  const FacebookLoginPage({super.key});
  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  bool _isLoggedIn = false;
  String? accessToken;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    // _checkIfLoggedInWithFacebook();
  }

  // Future<void> _checkIfLoggedInWithFacebook() async {
  //   try {
  //     final accessToken = await FacebookAuth.instance.accessToken;
  //     if (accessToken != null) {
  //       _loginToBackend(accessToken.token);
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> _loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final token = result.accessToken!.token;

      //  Send this token to  backend for verification + login
      await _loginToBackend(token);
      print("asdasdadasdaddddddddddddddddddddddddddddddddddddd");
    } else {
      print('Facebook login failed: ${result.message}');
    }
  }

  Future<void> _loginToBackend(String fbAccessToken) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8080/facebook/login',
        data: {'accessToken': fbAccessToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final jwt = data['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', jwt);

        setState(() {
          accessToken = jwt;
          _isLoggedIn = true;
        });

        print('✅ JWT Token stored: $jwt');
      } else {
        print('❌ Backend login failed: ${response.statusMessage}');
      }
    } catch (e) {
      print('❌ Dio error: $e');
    }
  }

  Future<void> _logout() async {
    await FacebookAuth.instance.logOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');

    setState(() {
      _isLoggedIn = false;
      accessToken = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Facebook Login')),
      body: Center(
        child:CircularProgressIndicator(
          
        )
        //  _isLoggedIn
        //     ? Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text('🔒 Logged in with JWT: $accessToken'),
        //           ElevatedButton(
        //             onPressed: _logout,
        //             child: Text('Logout'),
        //           ),
        //         ],
        //       )
        //     : ElevatedButton(
        //         onPressed: _loginWithFacebook,
        //         child: Text('Login with Facebook'),
        //       ),
      ),
    );
  }
}
