import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hatud/app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/server_routes.dart';
import '../../../data/models/items.dart';
import '../../../config/asset_routes.dart';
import '../../../data/models/items.dart';
import '../../../service/restaurant_service.dart';
import '../../../service/cart_service.dart';

class Item extends GetxController {
  final storage = const FlutterSecureStorage();
  Items? item;
  String? token;
  var res = Rxn<Restaurant>();

  @override
  void onInit() async {
    super.onInit();

    getKey();
  }

  void getKey() async {
    token = await storage.read(key: 'user_token');
    if (token == null) {
      Get.offAllNamed('/login');
    }

    item = Get.arguments as Items;
    res.value = await RestaurantService.getBasicDetails(token!, item!.resID);

    update();
  }

  void addToCart(int itemID, int qty) async {
    if (token == null) {
      Get.offAllNamed('/login');
    }
    bool success = await CartService.addToCart(token!, itemID, qty);

    if (success) {
      Get.toNamed('/cart');
    }
  }
}
