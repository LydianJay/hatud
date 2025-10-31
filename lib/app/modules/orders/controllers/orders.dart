import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../service/order_service.dart';

class Orders extends GetxController {
  final storage = const FlutterSecureStorage();

  var isLoading = true.obs;
  var hasError = false.obs;
  var activeOrder = Rxn<OrderResponse>();

  String? token;

  @override
  void onInit() {
    super.onInit();
    _loadTokenAndFetch();
  }

  Future<void> _loadTokenAndFetch() async {
    token = await storage.read(key: 'user_token');
    if (token == null) {
      Get.offAllNamed('/login');
      return;
    }
    await fetchActiveOrder();
  }

  Future<void> fetchActiveOrder() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final orderResponse = await OrderService.getActiveOrder(token!);

      if (orderResponse != null) {
        activeOrder.value = orderResponse;
      } else {
        activeOrder.value = null;
      }
    } catch (e) {
      hasError.value = true;
      print("❌ Error fetching active order: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void refreshOrder() async => await fetchActiveOrder();
}
