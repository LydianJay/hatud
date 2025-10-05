// ignore: file_names
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/server_routes.dart';

class Auth extends GetxController {
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;
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
    isLoading.value = true;

    if(emailController.text.isEmpty || passwordController.text.isEmpty) {
      
      Get.snackbar(
        'Error',
        'Empty email or password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      
      isLoading.value = false;
      
    }


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
      final data = jsonDecode(response.body);
      final msg = data['msg'];
      Get.snackbar(
        'Error',
        msg,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    final url = Uri.parse(ServerRoutes.registerRoute);

    try {
      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'email': emailController.text.trim(),
          'fname': fnameController.text.trim(),
          'lname': lnameController.text.trim(),
          'mname': mnameController.text.trim(),
          'dob': dobController.text.trim(),
          'contactno': contactController.text.trim(),
          'gender': selectedGender.value,
          'password': passwordController.text.trim(),
          'address': addressController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint(data['error'].toString());

        final code = int.parse(data['error'].toString());

        if (code == 1) {
          Get.snackbar(
            'Error',
            data['msg'] ?? 'Registration failed',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Success',
            data['msg'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Future.delayed(const Duration(seconds: 3), () {
            Get.toNamed('/login');
          });
        }
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Error', error['msg'] ?? 'Registration failed',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
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
