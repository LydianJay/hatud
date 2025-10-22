import 'package:flutter/material.dart';
import 'package:hatud/app/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/server_routes.dart';

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
    debugPrint(uri.toString());
    debugPrint(token);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('User service:');
      debugPrint(data.toString());
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
}
