import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orders.dart';
import '../../../config/asset_routes.dart';
import '../../../data/models/orderitemmodel.dart';

class OrdersView extends GetView<Orders> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Active Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshOrder,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("⚠️ Failed to load order."),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.refreshOrder,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        final orderResponse = controller.activeOrder.value;
        if (orderResponse == null) {
          return const Center(child: Text("No active orders"));
        }

        final info = orderResponse.orderInfo;
        final items = orderResponse.items;
        final delivery = orderResponse.delivery ?? 0;
        final total = orderResponse.fee;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 🧾 Order Information
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.blue),
                title: Text(
                  "Order #${info.id}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Date: ${info.date}\n"
                  "Status: ${info.status}\n"
                  "Payment: ${info.payMethod}",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🍔 Ordered Items
            Text(
              "Ordered Items",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            ...items.map((OrderItemModel item) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "${AssetRoutes.itemThumbRoute}${item.itemThumb}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  title: Text(item.itemName),
                  subtitle: Text("₱${item.price} × ${item.qty}"),
                  trailing: Text(
                    "₱${(item.price * item.qty).toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // 💸 Totals
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text("Delivery Fee"),
                trailing: Text("₱${delivery.toStringAsFixed(2)}"),
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text("Total Item Amount"),
                trailing: Text("₱${total.toStringAsFixed(2)}"),
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text(
                  "Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "₱${(delivery + total).toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
