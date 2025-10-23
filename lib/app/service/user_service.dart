import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hatud/app/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/server_routes.dart';
import 'dart:io';

class UserService {
  static User? cachedUser;
  static String? cachedToken;

  static Future<User?> getUser(String token) async {
    final uri = Uri.parse(ServerRoutes.getUser);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // debugPrint(uri.toString());
    // debugPrint(token);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // debugPrint(data.toString());
      final json = data['user'];
      cachedUser = User.fromJson(json);
      cachedToken = token;
      return cachedUser;
    } else {
      debugPrint('Error Occured in User Service');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
    }
    return null;
  }

  static Future<bool> updateUser(
    String token,
    Map<String, dynamic> userData, {
    File? imageFile,
  }) async {
    final uri = Uri.parse(ServerRoutes.updateUser);
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json';

    userData.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ));
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        debugPrint('✅ User updated: ${response.body}');
        final data = jsonDecode(response.body);
        final msg = data['msg'] ?? 'Profile updated successfully';

        Get.snackbar(
          'Success',
          msg.toString(),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        getUser(token);
        return true;
      } else {
        debugPrint('❌ Failed: ${response.body}');
        final data = jsonDecode(response.body);
        final msg = data['msg'] ?? 'Failed to update user';

        Get.snackbar(
          'Error',
          msg.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      debugPrint('❌ Exception: $e');
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }
}
