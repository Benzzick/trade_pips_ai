import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_controller.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';

class NotificationsIconButton extends GetView<NotificationsController> {
  const NotificationsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        Get.toNamed(AppRoutes.notifications);
      },
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(15),
        backgroundColor: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            "assets/icons/notification.png",
            scale: 2,
          ),
          if (controller.notifications.isNotEmpty)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 0, 0, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
