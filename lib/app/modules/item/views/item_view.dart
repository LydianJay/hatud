import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item.dart';
import '../../../widgets/item_background_card.dart';
import '../../../config/asset_routes.dart';

class ItemView extends GetView<Item> {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white.withAlpha(120),
      body: GetBuilder<Item>(
        builder: (controller) {
          if (controller.item == null) {
            return const Center(child: CircularProgressIndicator());
          }
          const thumbRoute = AssetRoutes.itemThumbRoute;
          return SafeArea(
            child: ListView(
              padding: EdgeInsets.only(top: width * 0.05, bottom: 20),
              children: [
                ItemBackgroundCard(
                  imageUrl: '$thumbRoute${controller.item!.thumb}',
                  title: controller.item!.name,
                  description: controller.item!.desc,
                  restaurant: controller.res.value!.name,
                  price: controller.item!.price,
                  address: controller.res.value!.address,
                  contactNo: controller.res.value!.contact,
                  openDays: controller.res.value!.daysToString(),
                  openTime: controller.res.value!.start +
                      "-" +
                      controller.res.value!.end,
                  onAddToCart: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
