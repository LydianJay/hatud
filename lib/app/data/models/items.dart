class Items {
  final int id;
  final String name;
  final String desc;
  final String thumb;
  final List<String> img;
  final List<int> category;
  final int resID;
  final double price;

  Items({
    required this.id,
    required this.name,
    required this.desc,
    required this.thumb,
    required this.img,
    required this.category,
    required this.resID,
    required this.price,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      thumb: json['thumb'],
      img: List<String>.from(json['img']),
      category: (json['category'] as List)
          .map((e) => int.tryParse(e.toString()) ?? 0)
          .toList(),
      resID: json['res_id'],
      price: (json['price'] as num).toDouble(),
    );
  }

  
}
