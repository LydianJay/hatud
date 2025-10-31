import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/server_routes.dart';
import '../data/models/cartmodel.dart';

class CartResponse {
  final List<CartModel> items;
  final double? delivery;

  CartResponse({required this.items, required this.delivery});
}

class CartService {
  static Future<bool> addToCart(String token, int itemID, int qty) async {
    final uri = Uri.parse(ServerRoutes.addItem);

    try {
      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'item_id': itemID,
          'qty': qty,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['error'] == 0) {
          debugPrint('Added to cart successfully');
          return true;
        } else {
          debugPrint('Failed: ${data['msg']}');
        }
      } else {
        debugPrint('HTTP Error: ${response.statusCode}');
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint('Exception occurred in addToCart: $e');
    }

    return false;
  }

  static Future<CartResponse> getCartItems(String token) async {
    final uri = Uri.parse(ServerRoutes.getCartItems);

    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['error'] == 0 && data['items'] != null) {
          debugPrint('Cart Service! Get Cart Items');
          debugPrint(data.toString());

          List<CartModel> cartItems = (data['items'] as List)
              .map((item) => CartModel.fromJson(item))
              .toList();

          return CartResponse(
            items: cartItems,
            delivery: (data['fee'] as num).toDouble(),
          );
        } else {
          debugPrint('Server returned error: ${data['msg']}');
          return CartResponse(items: [], delivery: 0.0);
        }
      } else {
        debugPrint('HTTP Error: ${response.statusCode}');
        debugPrint(response.body);
        return CartResponse(items: [], delivery: 0.0);
      }
    } catch (e) {
      debugPrint('Exception occurred in getCartItems: $e');
      return CartResponse(items: [], delivery: 0.0);
    }
  }

  static Future<bool> adjustQTY(String token, int qty, int itemID) async {
    final uri = Uri.parse(ServerRoutes.adjustItem);

    try {
      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'item_id': itemID,
          'qty': qty,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['error'] == 0) {
          return true;
        } else {
          debugPrint('adjustQTY | Server returned error: ${data['msg']}');
          return false;
        }
      } else {
        debugPrint('adjustQTY | HTTP Error: ${response.statusCode}');
        debugPrint(response.body);
        return false;
      }
    } catch (e) {
      debugPrint('Exception occurred in adjustQTY: $e');
      return false;
    }
  }

  static Future<bool> checkOut(String token) async {
    final uri = Uri.parse(ServerRoutes.checkout);

    try {
      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['error'] == 0) {
          return true;
        } else {
          debugPrint('checkOut | Server returned error: ${data['msg']}');
          return false;
        }
      } else {
        debugPrint('checkOut | HTTP Error: ${response.statusCode}');
        debugPrint(response.body);
        return false;
      }
    } catch (e) {
      debugPrint('Exception occurred in checkOut: $e');
      return false;
    }
  }
}
