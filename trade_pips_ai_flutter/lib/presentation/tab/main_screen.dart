import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/charts/charts_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/settings/settings_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/tab/main_screen_controller.dart';

class MainScreen extends GetView<MainScreenController> {
  MainScreen({super.key});

  // Keep widget instances
  final List<Widget> _widgets = [
    SignalsScreen(),
    ChartsScreen(),
    NewsScreen(),
    SettingsScreen(),
  ];

  final List<Map> _pages = const [
    {
      "title": "Signals",
      "iconPath": "assets/icons/signals.png",
    },
    {
      "title": "Charts",
      "iconPath": "assets/icons/charts.png",
    },
    {
      "title": "News",
      "iconPath": "assets/icons/news.png",
    },
    {
      "title": "Settings",
      "iconPath": "assets/icons/settings.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Obx(
        () => Scaffold(
          body: Obx(() {
            // Show loader on first load
            if (!controller.hasLoaded.value && controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.secondary,
                  color: Colors.white,
                  strokeCap: StrokeCap.round,
                ),
              );
            }

            // Show retry if failed
            if (!controller.hasLoaded.value && !controller.isLoading.value) {
              return Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Transform.scale(
                          scale: 0.9 + (0.1 * value),
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 🌐 Animated error illustration
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.95, end: 1.05),
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeInOut,
                        builder: (context, v, child) {
                          return Transform.scale(scale: v, child: child);
                        },
                        onEnd: () {},
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Lottie.asset(
                            "assets/lottie/no-internet.json",
                            repeat: true,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// 🔁 Animated retry button
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1, end: 1),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, v, child) {
                          return Transform.scale(scale: v, child: child);
                        },
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: controller.getMainScreenData,
                            icon: const Icon(
                              Icons.refresh_rounded,
                              color: AppColors.secondary,
                            ),
                            label: const Text(
                              "Retry",
                              style: TextStyle(color: AppColors.secondary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return IndexedStack(
              index: controller.currentIndex.value,
              children: _widgets.map((widget) {
                return RefreshIndicator(
                  onRefresh: controller.getMainScreenData,
                  backgroundColor: Colors.white,
                  color: AppColors.secondary,
                  strokeWidth: 3,
                  displacement: 60,
                  child: Stack(
                    children: [
                      ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      ),
                      widget,
                    ],
                  ),
                );
              }).toList(),
            );
          }),

          bottomNavigationBar: SizedBox(
            height: 75,
            child: BottomNavigationBar(
              backgroundColor: AppColors.secondary,
              currentIndex: controller.currentIndex.value,
              selectedLabelStyle: TextStyle(
                fontSize: 12,
                color: AppColors.tertiary,
              ),
              unselectedLabelStyle: TextStyle(fontSize: 12),
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                controller.currentIndex.value = index;
              },
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: List.generate(
                _pages.length,
                (index) {
                  return BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          _pages[index]["iconPath"]!,
                          scale: 2,
                          color: controller.currentIndex.value == index
                              ? AppColors.tertiary
                              : AppColors.primary,
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                    label: _pages[index]["title"]!,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
