import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home.dart';
import '../../../widgets/custom_searchbar.dart';
import '../../../config/asset_routes.dart';

class HomeView extends GetView<Home> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white.withAlpha(120),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: width * 0.05, bottom: 20),
          children: [
            /// Logo
            Container(
              margin: EdgeInsets.only(top: width * 0.1),
              width: width * 0.4,
              height: width * 0.4,
              child: Image.asset(
                'assets/img/icons/hatud_small.png',
                fit: BoxFit.contain,
              ),
            ),

            /// User name
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Obx(() {
                if (controller.name.value.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Text(
                  controller.name.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ),

            /// Search bar
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomSearchbar(
                hintText: 'Restaurant, Food and more!',
                controller: controller.searchctrl,
                onSubmit: controller.onSearchSubmit,
              ),
            ),

            /// RESTAURANTS
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'RESTAURANTS',
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (controller.restaurants.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    String thumbRoute = AssetRoutes.resThumbRoute;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.restaurants.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    '$thumbRoute${item.thumb}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  item.address,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "${item.start} - ${item.end}",
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// POPULAR ITEMS
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'POPULAR ITEMS',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (controller.items.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    String thumbRoute = AssetRoutes.itemThumbRoute;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.items.map((item) {
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    '$thumbRoute${item.thumb}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '₱${item.price.toStringAsFixed(0)}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
