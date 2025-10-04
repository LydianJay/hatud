import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint('Initialized');
    _initApp();
  }

  void _initApp() async {
    debugPrint('Called');
    await Future.delayed(const Duration(seconds: 3)); // splash delay
    debugPrint('Routinng....');
    Get.offAllNamed('/login'); // navigate after delay
  }
}
