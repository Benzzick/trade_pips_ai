import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';
import 'package:trade_pips_ai_flutter/core/services/storage_service.dart';
import 'package:trade_pips_ai_flutter/core/services/user_service.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';
import 'package:trade_pips_ai_flutter/core/widgets/custom_snackbar_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Optional: allow upside-down portrait
  ]);

  runApp(const TradePipsAi());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Serverpod Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MyHomePage(title: 'Serverpod Example'),
//     );
//   }
// }

class TradePipsAi extends StatelessWidget {
  const TradePipsAi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TradePips AI',
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 300),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Mulish',
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(
        () {
          Get.put<UserController>(UserController());
          Get.put<UserService>(UserService());
          Get.put<StorageService>(StorageService());
          Get.put<TopSnackBarController>(TopSnackBarController());
        },
      ),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            SafeArea(child: TopSnackBarWidget()),
          ],
        );
      },
    );
  }
}
