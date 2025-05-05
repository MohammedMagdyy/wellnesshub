import 'package:dio/dio.dart';
import 'package:wellnesshub/core/helper_class/api.dart';

class OTP {
  Future<String> activeOtp({required String email,required String username,}) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/active?email=$email&username=$username',
      );

      if (response != null) {
        return response.toString(); // ensure it's String
      } else {
        return 'No response from server';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return 'Error: ${e.response?.data.toString()}';
      } else {
        return 'Connection error: ${e.message}';
      }
    } catch (e) {
      print('Unexpected error: $e');
      return 'An error occurred. Please try again.';
    }
  }
  Future<String> VerifyOtp({required String email,required String code}) async {
    try {
      final response = await API().post(
        url: 'http://10.0.2.2:8080/verify?email=$email&code=$code',
      );

      if (response != null&&response.toString()=='Account activated successfully!') {
        return response.toString(); // ensure it's String
      }else if(response != null&&response.toString()=='Invalid activation code.'){
        return response.toString();
      }
      else {
        return 'No response from server';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return 'Error: ${e.response?.data.toString()}';
      } else {
        return 'Connection error: ${e.message}';
      }
    } catch (e) {
      print('Unexpected error: $e');
      return 'An error occurred. Please try again.';
    }
  }

}
