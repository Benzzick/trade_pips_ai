import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/change_password_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/success_screen.dart';

class VerifyEmailScreen extends GetView<AuthController> {
  const VerifyEmailScreen({super.key, required this.isSignUp});

  final bool isSignUp;

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Verify Email",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "We sent a code to you at ${controller.emailCtrl.text}",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Change Email Address",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                            fontWeight: FontWeight.w300,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = Get.back,
                        ),
                      ),
                      Row(),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Didn’t receive any OTP code? ",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: "Resend code",
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.sendOtp,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => pinInputBox(index: index),
                    ),
                  ),

                  Obx(
                    () => Opacity(
                      opacity: controller.otp.value.length == 4 ? 1 : .5,
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.otp.value.length == 4
                                ? AppColors.secondary
                                : Colors.grey,
                          ),
                          onPressed: controller.otp.value.length == 4
                              ? () async {
                                  await controller.verifyOtp();
                                  controller.confirmPasswordCtrl.clear();
                                  controller.passwordCtrl.clear();
                                  if (isSignUp) {
                                    Get.offAll(SuccessScreen());
                                  } else {
                                    Get.back();
                                    Get.back();
                                    Get.to(ChangePasswordScreen());
                                  }
                                }
                              : () {},
                          child: const Text(
                            "Verify Code",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  keypad(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text keypadText(String value) {
    return Text(
      value,
      style: const TextStyle(
        fontFamily: 'Lexend Deca',
        fontSize: 35.5,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    );
  }

  Widget keypad() {
    return Column(
      children: [
        for (var row in [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
          ['*', '0', '⌫'],
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: row.map((key) {
                return keypadButton(
                  onTap: () {
                    if (key == '⌫') {
                      controller.removeOtp();
                    } else if (key != '*') {
                      controller.addOtp(key);
                    }
                  },
                  child: key == '⌫'
                      ? const Icon(
                          Icons.backspace_outlined,
                          size: 26,
                          color: Color(0xFF141B34),
                        )
                      : keypadText(key),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget keypadButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 102,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(300),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  Widget pinInputBox({required int index}) {
    return Obx(() {
      final otp = controller.otp.value;

      return Container(
        width: 78,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF031A34),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: const Color(0xFF031A34),
            width: 2,
          ),
        ),
        child: Text(
          index < otp.length ? otp[index] : '',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
