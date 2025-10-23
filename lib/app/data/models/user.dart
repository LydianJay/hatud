class User {
  final String fname;
  final String? mname;
  final String lname;
  final String contactno;
  final String gender;
  final String email;
  final bool isVerified;
  final double lat;
  final double long;
  final String? photo; // URI for photo
  final String address;
  final int id;

  User({
    required this.fname,
    required this.mname,
    required this.lname,
    required this.contactno,
    required this.gender,
    required this.email,
    required this.isVerified,
    required this.lat,
    required this.long,
    required this.id,
    required this.photo,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fname: json['fname'],
      mname: json['mname'] ?? '',
      lname: json['lname'],
      contactno: json['contactno'],
      gender: json['gender'] ?? 'other',
      email: json['email'],
      photo: json['photo'],
      isVerified: json['is_verified'] == 1 ? true : false,
      lat: json['lat'] ?? 0,
      long: json['long'] ?? 0,
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'contactno': contactno,
      'gender': gender,
      'email': email,
      'is_verified': isVerified,
      'lat': lat,
      'long': long,
      'address': address,
    };
  }
}
