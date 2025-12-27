import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_list_widget.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -200,
            top: -200,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 150,
                sigmaY: 150,
              ),
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(55, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: Get.back,
                            child: Transform.rotate(
                              angle: -pi, // 90 degrees counter-clockwise
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.all(15),
                                child: Image.asset(
                                  'assets/icons/arrow.png',
                                  scale: 2,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notifications",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Stay Active With The Live Trading Signals",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Expanded(child: NotificationsListWidget()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
