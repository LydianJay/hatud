class CartModel {
  final int id;
  final int qty;
  final String res_name;
  final String res_thumb;
  final String item_name;
  final String item_thumb;
  final int item_id;
  final double price;

  CartModel({
    required this.id,
    required this.qty,
    required this.res_name,
    required this.res_thumb,
    required this.item_name,
    required this.item_thumb,
    required this.item_id,
    required this.price,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      qty: json['qty'] is int ? json['qty'] : int.parse(json['qty'].toString()),
      res_name: json['res_name'] ?? '',
      res_thumb: json['res_thumb'] ?? '',
      item_name: json['item_name'] ?? '',
      item_thumb: json['item_thumb'] ?? '',
      item_id: json['item_id'] is int
          ? json['item_id']
          : int.parse(json['item_id'].toString()),
      price: json['price'] is double
          ? json['price']
          : double.parse(
              json['price'].toString(),
            ),
    );
  }
}
