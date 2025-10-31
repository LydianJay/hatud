import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/server_routes.dart';
import '../data/models/orderitemmodel.dart';
import '../data/models/cartmodel.dart';
import '../data/models/orderinfo.dart';

class OrderResponse {
  final List<OrderItemModel> items;
  final OrderInfo orderInfo;
  final double? delivery;
  final double fee;

  OrderResponse(this.orderInfo, this.fee,
      {required this.items, required this.delivery});
}

class OrderService {
  static Future<OrderResponse?> getActiveOrder(String token) async {
    final uri = Uri.parse(ServerRoutes.getOrder); // your backend route

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
        final data = json.decode(response.body);
        debugPrint('------------------------');
        debugPrint(response.body);
        debugPrint('------------------------');
        if (data['error'] == 0) {
          final orderInfo = OrderInfo.fromJson(data['orderinfo']);
          final items = (data['items'] as List).map((i) {
            return OrderItemModel.fromJson(i);
          }).toList();

          return OrderResponse(
            orderInfo,
            data['total'].toDouble(),
            items: items,
            delivery: data['delivery'],
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error loading order: $e');
      return null;
    }
  }
}
