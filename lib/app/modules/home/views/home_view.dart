import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home.dart';
import '../../../widgets/custom_searchbar.dart';
import '../../../config/asset_routes.dart';

class HomeView extends GetView<Home> {
  const HomeView({super.key});

  // Pages for each tab

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // final height = size.height;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(120),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: width * 0.05),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: width * 0.1),
                  width: width * 0.4,
                  height: width * 0.4,
                  child: Image.asset(
                    'assets/img/icons/hatud_small.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Hi, Lydian Jay!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomSearchbar(
                    hintText: 'Restaurant, Food and more!',
                    controller: controller.searchctrl,
                    onSubmit: controller.onSearchSubmit,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'RESTAURANTS',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // 👈 important
                        child: Row(
                          children: List.generate(10, (index) {
                            return Container(
                              width: 120,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.blue[(index + 1) * 100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Item $index",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'POPULAR ITEMS',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        if (controller.items.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        String thumRoute = AssetRoutes.itemThumbRoute;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: controller.items.map(
                              (item) {
                                return Container(
                                  width: 120,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          '$thumRoute${item.thumb}',
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
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
