// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/server_routes.dart';

class Auth extends GetxController {
  var isPasswordHidden = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Controllers
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mnameController = TextEditingController();
  final dobController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final selectedGender = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    debugPrint('Logging In!');
    final uri = Uri.parse(ServerRoutes.loginRoute);
    debugPrint(uri.toString());
    final response = await http.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      debugPrint('Token: $token');
    } else {
      debugPrint('Login failed: ${response.body}');
    }
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
