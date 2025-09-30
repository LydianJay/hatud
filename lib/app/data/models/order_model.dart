enum OrderStatus { pending, cooking, delivery, delivered, cancelled }

enum OrderPaymentMethod { cod, ewallet }

class OrderModel {
  final int id;
  final int resID;
  final int riderID;
  final int clientID;
  final int refID;
  final DateTime date;
  final String destination;
  final OrderPaymentMethod paymethod;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.resID,
    required this.riderID,
    required this.clientID,
    required this.date,
    required this.destination,
    required this.paymethod,
    required this.status,
    required this.refID,
  });
}
