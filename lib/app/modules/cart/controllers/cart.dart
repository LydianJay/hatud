import 'dart:io';
import 'dart:math';
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
  var isLocationSet = false.obs;
  var itemFee = 0.0.obs;
  var totalPrice = 0.0.obs;
  var deliveryFee = RxnDouble();

  final isProcessing = false.obs;
  final selectedPaymentMethod = "cod".obs;
  final deliveryAddress = "No address set".obs;

  Future<void> placeOrder() async {
    isProcessing.value = true;

    try {
      // perform API call to confirm order
      // ...
      Get.snackbar("Success", "Your order has been placed!");
      cartItems.clear();
    } catch (e) {
      Get.snackbar("Error", "Failed to place order");
    } finally {
      isProcessing.value = false;
    }
  }

  void adjustQTY(int itemID, int qty) async {
    if (token == null) {
      Get.offAllNamed('/login');
    }
    final index = cartItems.indexWhere((i) => i.item_id == itemID);

    bool isSuccess = await CartService.adjustQTY(token!, qty, itemID);
    if (index != -1 && isSuccess) {
      await fetchCartItems(token!);
    } else {
      Get.snackbar(
        'ERROR',
        'Could Not connect to server! Please try again later or check internet connection',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchCartItems(String token) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final cartItem = await CartService.getCartItems(token);
      if (cartItem.items.isNotEmpty) {
        cartItems.assignAll(cartItem.items);
        deliveryFee.value = cartItem.delivery;
        isLocationSet.value = UserService.cachedUser!.lat != null &&
            UserService.cachedUser!.long != null;
        debugPrint(isLocationSet.value.toString());
        itemFee.value = 0;
        for (var e in cartItems) {
          itemFee.value += (e.price * e.qty);
        }
        totalPrice.value = itemFee.value +
            (deliveryFee.value != null ? deliveryFee.value! : 0);
      } else {
        cartItems.clear();
        deliveryFee.value = null;
        totalPrice.value = 0;
        itemFee.value = 0;
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

  void checkout() {
    deliveryAddress.value = UserService.cachedUser != null
        ? UserService.cachedUser!.address
        : "Please go to 'Profile' and update your pin location!";

    Get.toNamed('/checkout');
  }
}
