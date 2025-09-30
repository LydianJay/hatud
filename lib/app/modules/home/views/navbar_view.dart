import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home.dart';
import '../../profile/views/profile_view.dart';
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
    final Home controller = Get.find();
    final List<Widget> pages = [
      const HomeView(),
      const ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: ConvexAppBar(
            onTap: controller.changeTab,
            items: const [
              TabItem(icon: Icon(Icons.home), title: 'Home'),
              TabItem(icon: Icon(Icons.person), title: 'Profile'),
            ],
          ),
        ));
  }
}
