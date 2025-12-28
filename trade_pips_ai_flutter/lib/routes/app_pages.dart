import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/charts/charts_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/settings/settings_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/subscribe_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/subscribe_screen.dart';
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
          Get.put<AuthController>(AuthController());
        },
      ),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(),
      binding: BindingsBuilder(
        () {
          Get.put<MainScreenController>(MainScreenController());
          Get.put<SignalsController>(SignalsController());
          Get.put<ChartsController>(ChartsController());
          Get.put<NewsController>(NewsController());
          Get.put<SettingsController>(SettingsController());
          Get.put<NotificationsController>(NotificationsController());
        },
      ),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => NotificationsScreen(),
    ),
    GetPage(
      name: AppRoutes.subscribe,
      page: () => SubscribeScreen(),
      binding: BindingsBuilder(
        () {
          Get.put<SubscribeController>(SubscribeController());
        },
      ),
    ),
  ];
}

class AppRoutes {
  static const auth = "/auth";
  static const main = "/main";
  static const notifications = "/notifications";
  static const subscribe = "/subscribe";
}
