import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash.dart';

class SplashView extends GetView<Splash> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/img/icons/hatud.jpg',
          width: width * 0.75,
          height: height * 0.85,
        ),
      ),
    );
  }
}
