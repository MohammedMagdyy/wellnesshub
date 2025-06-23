import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../../helper_class/accesstoken_storage.dart';
import '../../helper_class/api.dart';
import '../../helper_functions/HanleSessionExpired.dart';
import '../../helper_class/network_exception_class.dart';
import '../../models/update_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../../utils/global_var.dart';

MediaType _getMediaTypeFromFileName(String fileName) {
  final extension = fileName.split('.').last.toLowerCase();
  switch (extension) {
    case 'png':
      return MediaType('image', 'png');
    case 'webp':
      return MediaType('image', 'webp');
    case 'gif':
      return MediaType('image', 'gif');
    default:
      return MediaType('image', 'jpeg');
  }
}


class UpdateProfileService {

  Future<Map<String, dynamic>> updateProfile(UpdateData updateData) async {
    final token = await LocalStorageAccessToken.getToken();

    final response = await API().post(
      url: '$apiUrl/updateProfile',
      token: token,
      data: {
        'firstName': updateData.fName,
        'lastName': updateData.lName,
        'email': updateData.email,
        'age': updateData.age,
        'weight': updateData.weight,
        'height': updateData.height,
      },
    );

    if (response is String && response.contains('<html')) {
      await handleSessionExpired();
      throw NetworkException('Session expired. Please login again.');
    }

    if (response is Map && response['message'] != null) {
      return {
        'success': true,
        'message': response['message'],
      };
    } else {
      return {
        'success': false,
        'message': response is Map
            ? response['message'] ?? 'Update failed'
            : 'Invalid server response',
      };
    }
  }

  /// Upload profile picture
  Future<void> uploadProfilePicture(File imageFile) async {
    final token = await LocalStorageAccessToken.getToken();
    String fileName = imageFile.path.split('/').last;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: _getMediaTypeFromFileName(fileName),
      ),

    });

    await API().post(
      url: '$apiUrl/updateProfilePicture',
      data: formData,
      token: token,
    );
  }


  Future<File?> downloadProfilePicture() async {
    final token = await LocalStorageAccessToken.getToken();
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/profile_downloaded.jpg";
    File file = File(filePath);

    try {
      final response = await API.dio.get<List<int>>(
        '$apiUrl/getProfilePicture',
        options: Options(
          headers: API().buildHeaders(token),
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 204 || response.data == null || response.data!.isEmpty) {
        final byteData = await rootBundle.load('assets/default_avatar.png');
        if (file.existsSync()) {
          await file.delete(); // clean previous fallback image
        }
        await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
      } else {
        if (file.existsSync()) {
          await file.delete();
        }
        await file.writeAsBytes(response.data!, flush: true);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', file.path);

      return file;
    } catch (e) {
      throw NetworkException("Failed to download profile picture: $e");
    }
  }





}

