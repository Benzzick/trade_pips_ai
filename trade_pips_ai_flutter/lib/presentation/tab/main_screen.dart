import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/charts/charts_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/settings/settings_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/tab/main_screen_controller.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  final List<Map> _pages = const [
    {
      "widget": SignalsScreen(),
      "title": "Signals",
      "iconPath": "assets/icons/signals.png",
    },
    {
      "widget": ChartsScreen(),
      "title": "Charts",
      "iconPath": "assets/icons/charts.png",
    },
    {
      "widget": NewsScreen(),
      "title": "News",
      "iconPath": "assets/icons/news.png",
    },
    {
      "widget": SettingsScreen(),
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
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: _pages.map(
              (page) {
                return page["widget"] as Widget;
              },
            ).toList(),
          ),
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
                          _pages[index]["iconPath"],
                          scale: 2,
                          color: controller.currentIndex.value == index
                              ? AppColors.tertiary
                              : AppColors.primary,
                        ),
                        const SizedBox(height: 6), // 👈 spacing
                      ],
                    ),

                    label: _pages[index]["title"],
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
