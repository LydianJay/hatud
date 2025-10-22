import 'package:get/get.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/controllers/splash.dart';

import '../modules/home/views/navbar_view.dart';
import '../modules/home/controllers/home.dart';

import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/auth/controllers/auth.dart';

import '../modules/item/views/item_view.dart';
import '../modules/item/controllers/item.dart';

import '../modules/profile/controllers/profile.dart';
import '../modules/profile/views/profile_view.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const itemView = '/item_view';
  static const profile = '/profile';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashView(),
      binding: BindingsBuilder.put(() => Splash()),
    ),
    GetPage(
      name: login,
      page: () => const LoginView(),
      binding: BindingsBuilder.put(() => Auth()),
    ),
    GetPage(
      name: register,
      page: () => const RegisterView(),
      binding: BindingsBuilder.put(() => Auth()),
    ),
    GetPage(
      name: home,
      page: () => const NavbarView(),
      binding: BindingsBuilder(() {
        Get.put(Home());
        Get.lazyPut(() => Profile());
      }),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileView(),
      binding: BindingsBuilder.put(() => Profile()),
    ),
    GetPage(
      name: itemView,
      page: () => const ItemView(),
      binding: BindingsBuilder.put(() => Item()),
    ),
  ];
}
