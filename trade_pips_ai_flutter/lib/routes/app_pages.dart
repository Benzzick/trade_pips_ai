import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/screens/splash_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_service.dart';
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
import 'package:trade_pips_ai_flutter/presentation/tab/main_screen_service.dart';

class AppPages {
  static const initial = AppRoutes.auth;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.auth,
      page: () => AuthScreen(),
      binding: BindingsBuilder(
        () {
          Get.put<AuthController>(AuthController());
          Get.put<AuthService>(AuthService());
        },
      ),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<MainScreenController>(
            () => MainScreenController(),
            fenix: true,
          );
          Get.put<MainScreenService>(MainScreenService());
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
  static const splash = '/';
  static const auth = "/auth";
  static const main = "/main";
  static const notifications = "/notifications";
  static const subscribe = "/subscribe";
}
