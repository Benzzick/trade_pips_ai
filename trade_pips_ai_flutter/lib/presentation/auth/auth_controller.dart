import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/verify_email_screen.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';

class AuthController extends GetxController {
  final RxBool seePassword = true.obs;
  final RxBool isLogin = true.obs;
  final RxString otp = ''.obs;

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  void addOtp(String value) {
    if (otp.value.length < 4) {
      otp.value += value;
    }
  }

  void removeOtp() {
    if (otp.value.isNotEmpty) {
      otp.value = otp.value.substring(0, otp.value.length - 1);
    }
  }

  void clearOtp() {
    otp.value = '';
  }

  void toggleSeePassword() {
    seePassword.toggle();
  }

  void toggleisLogin() {
    isLogin.toggle();
  }

  Future<void> loginWithGoogle() async {
    int index = 1;
    while (true) {
      if (index.isOdd) {
        Get.find<TopSnackBarController>().show(
          message: "Trade executed successfully 💵",
          success: true,
        );
      } else {
        Get.find<TopSnackBarController>().show(
          message: "Insufficient balance!",
          success: false,
        );
      }

      index++;

      await Future.delayed(const Duration(seconds: 4));
    }
  }

  Future<void> loginWithEmail() async {
    final userController = Get.find<UserController>();
    if (DateTime.now().isBefore(
      userController.user.value.subscriptionEndDate,
    )) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.subscribe);
    }
  }

  Future<void> createAccount() async {
    Get.to(VerifyEmailScreen(isSignUp: true));
  }

  Future<void> sendOtp() async {
    otp.value = '';
  }

  Future<void> verifyOtp() async {}
}
