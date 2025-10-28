import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/server_routes.dart';
import '../data/models/cartmodel.dart';

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

  static Future<List<CartModel>> getCartItems(String token) async {
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
          // Map each JSON item to a CartModel
          debugPrint('Cart Service!');
          debugPrint(data.toString());
          List<CartModel> cartItems = (data['items'] as List)
              .map((item) => CartModel.fromJson(item))
              .toList();
          return cartItems;
        } else {
          debugPrint('Server returned error: ${data['msg']}');
          return [];
        }
      } else {
        debugPrint('HTTP Error: ${response.statusCode}');
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint('Exception occurred in getCartItems: $e');
      return [];
    }
  }
}
