import 'package:get/get.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/controllers/splash.dart';

import '../modules/home/views/navbar_view.dart';
import '../modules/home/controllers/home.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashView(),
      binding: BindingsBuilder.put(() => Splash()),
    ),
    GetPage(
      name: home,
      page: () => const NavbarView(),
      binding: BindingsBuilder.put(() => Home()),
    ),
  ];
}
