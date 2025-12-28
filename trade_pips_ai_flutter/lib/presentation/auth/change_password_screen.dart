import 'dart:ui';

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
                        "Hey, please change you password and login",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(),
                    ],
                  ),
                  SizedBox(
                    height: 35,
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
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.otp.value.length == 4
                            ? AppColors.secondary
                            : Colors.grey,
                      ),
                      onPressed: controller.loginWithEmail,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
