import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/core/services/storage_service.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _bounceAnimation =
        Tween<double>(
          begin: 200,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: _animController,
            curve: Curves.elasticOut, // 👈 Nice bounce effect
          ),
        );

    _animController.forward();

    _boot();
  }

  Future<void> _boot() async {
    await Future.delayed(const Duration(milliseconds: 2200));

    final storage = Get.find<StorageService>();
    final userController = Get.find<UserController>();

    final savedUser = storage.getUser();

    if (savedUser != null) {
      userController.user.value = savedUser;
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.auth);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: child,
                );
              },
              child: const Icon(
                Icons.trending_up,
                size: 90,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
