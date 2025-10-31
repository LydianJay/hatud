import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home.dart';
import '../../profile/views/profile_view.dart';
import '../../cart/views/cart_view.dart';
import '../../orders/views/orders_view.dart';
import '../views/home_view.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class NavbarView extends GetView<Home> {
  const NavbarView({super.key});

  // Pages for each tab

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final width = size.width;
    // final height = size.height;
    final theme = Theme.of(context);

    final Home controller = Get.find();
    final List<Widget> pages = [
      const HomeView(),
      const ProfileView(),
      const CartView(),
      const OrdersView(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: ConvexAppBar(
            onTap: controller.changeTab,
            color: Colors.white,
            backgroundColor: theme.appBarTheme.backgroundColor,
            activeColor: theme.colorScheme.secondary,

            // activeColor: theme.appBarTheme.foregroundColor,
            items: const [
              TabItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: 'Home',
              ),
              TabItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: 'Profile',
              ),
              TabItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                title: 'My Cart',
              ),
              TabItem(
                icon: Icon(
                  Icons.delivery_dining,
                  color: Colors.white,
                ),
                title: 'Orders',
              ),
            ],
          ),
        ));
  }
}
