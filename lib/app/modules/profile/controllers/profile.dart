import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hatud/app/data/models/user.dart';
import 'package:hatud/app/modules/home/controllers/home.dart';
import '../../../service/user_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Profile extends GetxController {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final storage = const FlutterSecureStorage();
  // final user = Rxn<User>();

  @override
  void onInit() {
    final home = Get.find<Home>();
    ever(home.user, (user) {
      if (user != null) {
        init(home);
      }
    });
    super.onInit();
  }

  void init(Home home) async {
    fnameController.text = home.user.value!.fname;
    lnameController.text = home.user.value!.lname;
    mnameController.text = home.user.value!.mname!;
    emailController.text = home.user.value!.email;
    
  }

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
