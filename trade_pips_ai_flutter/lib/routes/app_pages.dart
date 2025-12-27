import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/charts/charts_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/settings/settings_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/tab/main_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/tab/main_screen_controller.dart';

class AppPages {
  static const initial = AppRoutes.auth;

  static final routes = [
    GetPage(
      name: AppRoutes.auth,
      page: () => AuthScreen(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<AuthController>(() => AuthController());
        },
      ),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<MainScreenController>(() => MainScreenController());
          Get.lazyPut<SignalsController>(() => SignalsController());
          Get.lazyPut<ChartsController>(() => ChartsController());
          Get.lazyPut<NewsController>(() => NewsController());
          Get.lazyPut<SettingsController>(() => SettingsController());
          Get.lazyPut<NotificationsController>(() => NotificationsController());
        },
      ),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => NotificationsScreen(),
    ),
  ];
}

class AppRoutes {
  static const auth = "/auth";
  static const main = "/main";
  static const notifications = "/notifications";
}
