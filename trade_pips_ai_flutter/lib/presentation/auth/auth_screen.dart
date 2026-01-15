import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/app_colors.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !controller.isLogin.value,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;

        if (!controller.isLogin.value) {
          controller.toggleisLogin();
        } else {
          // SystemNavigator.pop();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark, // iOS
        ),
        child: Scaffold(
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
                  child: AutofillGroup(
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.isLogin.value
                                  ? "Hey, \nWelcome Back"
                                  : "Create An \nAccount Now",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => Text(
                              controller.isLogin.value
                                  ? 'Good to see you back!'
                                  : "To access all feature please create an account",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: controller.emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                              prefixIcon: SizedBox(
                                width: 48,
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Image.asset(
                                      'assets/icons/mail.png',
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
                          if (!controller.isLogin.value) ...[
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
                                          onPressed:
                                              controller.toggleSeePassword,
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
                          ],
                          if (controller.isLogin.value) ...[
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Forgot Password?",
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 15,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = controller.isLoading.value
                                          ? () {}
                                          : () {
                                              showCustomBottomModal(context);
                                            },
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                              ),
                              onPressed: controller.isLoading.value
                                  ? () {}
                                  : controller.isLogin.value
                                  ? controller.loginWithEmail
                                  : controller.sendOtpToCreateAccount,
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
                                  : Text(
                                      controller.isLogin.value
                                          ? "Login"
                                          : "Create Account",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Or continue with',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(),
                              icon: Image.asset(
                                "assets/icons/google.png",
                                scale: 2,
                              ),
                              onPressed: controller.isLoading.value
                                  ? () {}
                                  : controller.loginWithGoogle,
                              label: controller.isLoading.value
                                  ? SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        color: Colors.black,
                                        strokeCap: StrokeCap.round,
                                      ),
                                    )
                                  : Text(
                                      "Google",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                          ),
                          if (controller.isLogin.value) ...[
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Don’t have an account? ",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(183, 183, 183, 1),
                                      fontSize: 19,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Sign up",
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 19,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.primary,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = controller.isLoading.value
                                              ? () {}
                                              : controller.toggleisLogin,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCustomBottomModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) {
        return Obx(
          () => Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Container(
                  color: Colors.black.withAlpha(0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 370,
                      width: 440,
                      margin: EdgeInsets.only(top: 279.5),
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 142,
                            height: 7,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Input Email",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Please input an email address where we can send a reset token!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: controller.emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                                prefixIcon: Image.asset(
                                  'assets/icons/mail.png',
                                  scale: 2,
                                  color: Colors.black,
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
                                    color: Color.fromRGBO(3, 1, 29, 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                              ),
                              onPressed: controller.isLoading.value
                                  ? () {}
                                  : controller.sendOtpToResetPassword,
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
                                  : Text(
                                      "Send",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
