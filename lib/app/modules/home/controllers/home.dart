import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hatud/app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/server_routes.dart';
import '../../../data/models/items.dart';
import '../../../config/asset_routes.dart';

class Home extends GetxController {
  var selectedIndex = 0.obs;
  final searchctrl = TextEditingController();
  final storage = const FlutterSecureStorage();
  var items = <Items>[].obs;
  var restaurants = <Restaurant>[].obs;
  var name = ''.obs;
  String? token;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void onSearchSubmit(String text) {
    debugPrint(text);
  }

  void getPopularItems() async {
    final uri = Uri.parse(ServerRoutes.getPopularItems);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final itemsJson = data['items'] as List;

      // debugPrint(itemsJson.toString());

      items.value = itemsJson.map((i) => Items.fromJson(i)).toList();

      // debugPrint('Parsed ${items.length} items');
      // debugPrint('First item: ${items[0].name} - ₱${items[0].price}');
    } else {
      final data = jsonDecode(response.body);
      debugPrint(data.toString());
    }
  }

  void getRestaurants() async {
    final uri = Uri.parse(ServerRoutes.getRestaurants);
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final itemsJson = data['items'] as List;
      debugPrint('Get Restaurants');
      debugPrint(itemsJson.toString());

      final resItems = itemsJson.map((i) => Restaurant.fromJson(i)).toList();
      restaurants.value = resItems;

      debugPrint(resItems.toString());
    } else {
      final data = jsonDecode(response.body);
      debugPrint(data.toString());
    }
  }

  void getClientInfo() async {
    final uri = Uri.parse(ServerRoutes.getClientDetails);

    debugPrint(uri.toString());
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // debugPrint("Get Client info ${jsonDecode(response.body).toString()}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      name.value = data['user']['fname'];
    } else if (response.statusCode == 401) {
      Get.snackbar(
        'Error',
        'Not logged in',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      await Future.delayed(const Duration(seconds: 5));
      await storage.delete(key: 'user_token');
      Get.offAllNamed('/login');
    } else {
      final data = jsonDecode(response.body);
      debugPrint("Response code: ${response.statusCode}");
      debugPrint(data.toString());
    }
  }

  @override
  void onInit() async {
    super.onInit();

    token = await storage.read(key: 'user_token');
    if (token != null) {
      getClientInfo();
      getPopularItems();
      getRestaurants();
    }
  }
}
