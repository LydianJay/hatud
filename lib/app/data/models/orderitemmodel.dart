class OrderItemModel {
  final String resName;
  final String itemName;
  final String itemThumb;
  final double price;
  final int qty;
  final int isPending;
  final double resLong;
  final double resLat;
  final int resId;

  OrderItemModel({
    required this.resName,
    required this.itemName,
    required this.itemThumb,
    required this.price,
    required this.qty,
    required this.isPending,
    required this.resLong,
    required this.resLat,
    required this.resId,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    double safeToDouble(value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value.trim()) ?? 0.0;
      return 0.0;
    }

    int safeToInt(value) {
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value.trim()) ?? 0;
      return 0;
    }

    return OrderItemModel(
      resName: json['res_name'] ?? '',
      itemName: json['item_name'] ?? '',
      itemThumb: json['item_thumb'] ?? '',
      price: safeToDouble(json['price']),
      qty: safeToInt(json['qty']),
      isPending: safeToInt(json['is_pending']),
      resLong: safeToDouble(json['res_long']),
      resLat: safeToDouble(json['res_lat']),
      resId: safeToInt(json['res_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'res_name': resName,
      'item_name': itemName,
      'item_thumb': itemThumb,
      'price': price,
      'qty': qty,
      'is_pending': isPending,
      'res_long': resLong,
      'res_lat': resLat,
      'res_id': resId,
    };
  }
}
