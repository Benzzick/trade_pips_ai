import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_controller.dart';

class ChangePasswordScreen extends GetView<AuthController> {
  const ChangePasswordScreen({super.key});

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
                        "Change Password",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "We sent a token to you at ${controller.emailCtrl.text}",
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
                  Obx(() {
                    return Text.rich(
                      TextSpan(
                        text: "Didn’t receive any OTP code? ",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 15,
                        ),
                        children: [
                          controller.canResend.value
                              ? TextSpan(
                                  text: "Resend code",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = controller.isLoading.value
                                        ? () {}
                                        : controller.sendOtpToResetPassword,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : TextSpan(
                                  text:
                                      "Resend in ${controller.resendSeconds.value}s",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(
                    height: 35,
                  ),
                  Obx(
                    () => TextField(
                      controller: controller.passwordResetTokenCtrl,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      obscureText: controller.seePassword.value,
                      decoration: InputDecoration(
                        hintText: 'Password Reset Token',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        suffixIcon: SizedBox(
                          width: 60,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: controller.toggleSeePassword,
                                icon: Image.asset(
                                  'assets/icons/eye.png',
                                  scale: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        prefixIcon: SizedBox(
                          width: 48,
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Image.asset(
                                'assets/icons/lock.png',
                                scale: 2,
                              ),
                            ],
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 187, 200, 212),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => TextField(
                      controller: controller.passwordCtrl,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      obscureText: controller.seePassword.value,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        suffixIcon: SizedBox(
                          width: 60,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: controller.toggleSeePassword,
                                icon: Image.asset(
                                  'assets/icons/eye.png',
                                  scale: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        prefixIcon: SizedBox(
                          width: 48,
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Image.asset(
                                'assets/icons/lock.png',
                                scale: 2,
                              ),
                            ],
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 187, 200, 212),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => TextField(
                      controller: controller.confirmPasswordCtrl,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      obscureText: controller.seePassword.value,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                        suffixIcon: SizedBox(
                          width: 60,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: controller.toggleSeePassword,
                                icon: Image.asset(
                                  'assets/icons/eye.png',
                                  scale: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        prefixIcon: SizedBox(
                          width: 48,
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Image.asset(
                                'assets/icons/lock.png',
                                scale: 2,
                              ),
                            ],
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 187, 200, 212),
                          ),
                        ),
                      ),
                    ),
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
                            : controller.confirmPasswordReset,
                        child: controller.isLoading.value
                            ? SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  backgroundColor: AppColors.secondary,
                                  color: Colors.white,
                                  strokeCap: StrokeCap.round,
                                ),
                              )
                            : const Text(
                                "Login",
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
