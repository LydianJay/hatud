import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home.dart';

class HomeView extends GetView<Home> {
  const HomeView({super.key});

  // Pages for each tab

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final width = size.width;
    // final height = size.height;

    return const Scaffold(body: Text('Home'));
  }
}
