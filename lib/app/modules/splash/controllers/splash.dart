import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Splash extends GetxController {
  final storage = const FlutterSecureStorage();
  @override
  void onInit() {
    super.onInit();

    debugPrint('Initialized');
    _initApp();
  }

  void _initApp() async {
    String? token = await storage.read(key: 'user_token');
    await Future.delayed(const Duration(seconds: 3));

    if (token == null) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/home');
    }
  }
}
