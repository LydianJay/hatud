import 'package:flutter/material.dart';

class OrderInfo {
  final int id;
  final String date;
  final double amount;
  final String status;
  final String payMethod;

  OrderInfo({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.payMethod,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    try {
      dynamic amountVal = json['amount'];
      double parsedAmount = 0.0;

      if (amountVal is num) {
        parsedAmount = amountVal.toDouble();
      } else if (amountVal is String) {
        parsedAmount = double.tryParse(amountVal.trim()) ?? 0.0;
      }

      return OrderInfo(
        id: json['id'] is int
            ? json['id']
            : int.tryParse(json['id'].toString().trim()) ?? 0,
        date: json['date'] ?? '',
        amount: parsedAmount,
        status: json['status'] ?? '',
        payMethod: json['pay_method'] ?? '',
      );
    } catch (e, stack) {
      debugPrint('⚠️ Error parsing OrderInfo.fromJson');
      debugPrint('JSON data: $json');
      debugPrint('Error: $e');
      debugPrint('Stacktrace:\n$stack');
      rethrow; // let it bubble up after logging
    }
  }
}
