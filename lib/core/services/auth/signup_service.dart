import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';


class SignupService {
  Future<Map<String, dynamic>> signup(String fname,String lname,String email, String password) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/register',
        data: {'firstName': fname,'lastName': lname,'email': email, 'password': password},
        token: null,
      );

      // If the response contains an access token, login is successful.
      if (response != null && response['message'] != null) {
        return {'success': true, 'message': response['message']};
      } else {
        // If response does not contain access token, but there is a message, return the message.
        return {
          'success': false,
          'message': response['message'] ?? 'SignUp failed'
        };
      }
    } on DioException catch (e) {
      // Handle error response properly in case of failure.
      if (e.response != null) {
        // If response contains a message, return it.
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'An error occurred. Please try again.'
        };
      } else {
        // If there's no response, it means network issue or other error.
        return {'success': false, 'message': 'An error occurred. Please try again.'};
      }
    } catch (e) {
      // General catch for unexpected errors.
      print('Unexpected error: $e');
      return {'success': false, 'message': 'An error occurred. Please try again.'};
    }
  }
}






/*
 try {
      final response = await _dio.post(
        'https://your-backend.com/api/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        LocalStorage.saveToken(response.data['token']);
        return true;
      }
    } on DioException catch (e) {
      print("Login error: ${e.response?.data ?? e.message}");
    }
    return false;
*/
