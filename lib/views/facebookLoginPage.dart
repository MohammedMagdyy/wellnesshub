import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookLoginPage extends StatefulWidget {
  static const routeName = 'FacebookLoginPage';
  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  bool _isLoggedIn = false;
  String? _jwtToken;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _checkIfLoggedInWithFacebook();
  }

  Future<void> _checkIfLoggedInWithFacebook() async {
    try {
      final accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        _loginToBackend(accessToken.token);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
    final token = result.accessToken!.token;
  
  //  Send this token to  backend for verification + login
    await _loginToBackend(token);
    } else {
      print('Facebook login failed: ${result.message}');
    }

  
  }

  Future<void> _loginToBackend(String fbAccessToken) async {
    try {
      final response = await _dio.post(
        'http://localhost:8080/facebook/login', // 👈 Replace with your backend URL
        data: {'accessToken': fbAccessToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final jwt = data['jwtToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', jwt);

        setState(() {
          _jwtToken = jwt;
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
    await prefs.remove('jwtToken');

    setState(() {
      _isLoggedIn = false;
      _jwtToken = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Facebook Login')),
      body: Center(
        child: _isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🔒 Logged in with JWT: $_jwtToken'),
                  ElevatedButton(
                    onPressed: _logout,
                    child: Text('Logout'),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: _loginWithFacebook,
                child: Text('Login with Facebook'),
              ),
      ),
    );
  }
}


