import 'package:intl/intl.dart';

class Restaurant {
  final int id;
  final String name;
  final String address;
  final double lat;
  final double long;
  final String contact;
  final String email;
  final String? owner;
  final int? resCatId;
  final String thumb;
  final String start;
  final String end;
  final List<int> days;
  final bool isActive;
  final String? photo;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.contact,
    required this.email,
    this.owner,
    this.resCatId,
    required this.thumb,
    required this.start,
    required this.end,
    required this.days,
    required this.isActive,
    this.photo,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    String formatTime(String? timeStr) {
      if (timeStr == null || timeStr.isEmpty) return '';
      try {
        final time = DateFormat('HH:mm:ss').parse(timeStr);
        return DateFormat('h:mm a').format(time); // e.g. 5:00 AM
      } catch (e) {
        return timeStr;
      }
    }

    return Restaurant(
      id: json['id'],
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      long: double.tryParse(json['long'].toString()) ?? 0.0,
      contact: json['contactno']?.toString() ?? '',
      email: json['email'] ?? '',
      owner: json['owner'] ?? '',
      resCatId: json['res_catid'],
      thumb: json['thumb'] ?? '',
      start: formatTime(json['optime_start']),
      end: formatTime(json['optime_end']),
      days: (json['optime_days'] is List)
          ? (json['optime_days'] as List)
              .map((e) => int.tryParse(e.toString()) ?? 0)
              .toList()
          : [],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      photo: json['photo'],
    );
  }

  factory Restaurant.basicDetails(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      lat: 0.0,
      long: 0.0,
      contact: json['contactno'] ?? '',
      email: '',
      thumb: json['thumb'] ?? '',
      start: json['optime_start'] ?? '',
      end: json['optime_end'] ?? '',
      days: (json['optime_days'] is List)
          ? (json['optime_days'] as List)
              .map((e) => int.tryParse(e.toString()) ?? 0)
              .toList()
          : [],
      isActive: true,
    );
  }

  List<String> daysToString() {
    final dayMap = {
      0: 'Sun',
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
    };

    return days.map((e) => dayMap[e] ?? '').toList();
  }
}
