import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_controller.dart';

class SuccessScreen extends GetView<AuthController> {
  const SuccessScreen({super.key});

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
                  Column(
                    children: [
                      Text(
                        "Successful",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Image.asset(
                    'assets/icons/success.png',
                    scale: 2,
                  ),
                  Spacer(),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                        ),
                        onPressed: controller.isLoading.value
                            ? () {}
                            : controller.sendfcmToken,
                        child: controller.isLoading.value
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  color: Colors.black,
                                  strokeCap: StrokeCap.round,
                                ),
                              )
                            : const Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
