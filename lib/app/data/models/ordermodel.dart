import '../models/cartmodel.dart';

class OrderModel {
  final int id;
  final String date;
  final String status;
  final String payMethod;
  final double total;
  final double delivery;
  final List<CartModel> cartItems;

  OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.payMethod,
    required this.total,
    required this.delivery,
    required this.cartItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final orderInfo = json['orderinfo'];

    double safeToDouble(value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value.trim()) ?? 0.0;
      return 0.0;
    }

    return OrderModel(
      id: orderInfo['id'] is int
          ? orderInfo['id']
          : int.tryParse(orderInfo['id'].toString().trim()) ?? 0,
      date: orderInfo['date'] ?? '',
      status: orderInfo['status'] ?? '',
      payMethod: orderInfo['pay_method'] ?? '',
      total: safeToDouble(json['total'] ?? json['fee']),
      delivery: safeToDouble(json['delivery']),
      cartItems: (json['items'] as List)
          .map((item) => CartModel.fromJson(item))
          .toList(),
    );
  }
}
