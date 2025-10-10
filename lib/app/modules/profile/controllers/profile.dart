import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends GetxController {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    fnameController.dispose();
    mnameController.dispose();
    lnameController.dispose();
    super.onClose();
  }
}
