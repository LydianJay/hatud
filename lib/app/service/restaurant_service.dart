import 'package:flutter/material.dart';
import 'package:hatud/app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/server_routes.dart';

class RestaurantService {
  static Future<Restaurant?> getBasicDetails(String token, int id) async {
    final uri = Uri.parse("${ServerRoutes.getResBasicDetails}?id=$id");
    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('From service:');
      debugPrint(data.toString());
      final json = data['item'];
      return Restaurant.basicDetails(json);
    } else {
      debugPrint('Error Occured in Service');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
    }
    return null;
  }
}
