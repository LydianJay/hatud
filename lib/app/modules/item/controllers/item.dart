import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hatud/app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/server_routes.dart';
import '../../../data/models/items.dart';
import '../../../config/asset_routes.dart';

class Item extends GetxController {
  final storage = const FlutterSecureStorage();
  String? token;

  @override
  void onInit() async {
    super.onInit();

    token = await storage.read(key: 'user_token');
    if (token == null) {
      Get.offAllNamed('/login');
    }
  }
}
