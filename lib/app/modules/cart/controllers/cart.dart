import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hatud/app/modules/home/controllers/home.dart';
import '../../../service/user_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/cartmodel.dart';
import '../../../service/cart_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Cart extends GetxController {
  var cartItems = <CartModel>[].obs;
  final storage = const FlutterSecureStorage();
  String? token;
  var isLoading = false.obs;
  var hasError = false.obs;

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.qty));

  void increaseQty(int itemId) {
    final index = cartItems.indexWhere((i) => i.item_id == itemId);
    if (index != -1) {
      cartItems[index] = CartModel(
        id: cartItems[index].id,
        qty: cartItems[index].qty + 1,
        res_name: cartItems[index].res_name,
        res_thumb: cartItems[index].res_thumb,
        item_name: cartItems[index].item_name,
        item_thumb: cartItems[index].item_thumb,
        item_id: cartItems[index].item_id,
        price: cartItems[index].price,
      );
    }
  }

  Future<void> fetchCartItems(String token) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final items = await CartService.getCartItems(token);

      if (items.isNotEmpty) {
        cartItems.assignAll(items);
      } else {
        cartItems.clear();
      }
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

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

    await fetchCartItems(token!);
  }

  void decreaseQty(int itemId) {
    final index = cartItems.indexWhere((i) => i.item_id == itemId);
    if (index != -1) {
      final current = cartItems[index];
      if (current.qty > 1) {
        cartItems[index] = CartModel(
          id: current.id,
          qty: current.qty - 1,
          res_name: current.res_name,
          res_thumb: current.res_thumb,
          item_name: current.item_name,
          item_thumb: current.item_thumb,
          item_id: current.item_id,
          price: current.price,
        );
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  void checkout() {
    // Implement checkout logic here
    Get.snackbar('Checkout', 'Proceeding to checkout...');
  }
}
