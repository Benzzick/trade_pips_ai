import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Future<void> loginWithGoogle() async {}

  Future<void> loginWithEmail() async {
    Get.offNamed(AppRoutes.main);
  }

  Future<void> createAccount() async {
    Get.to(VerifyEmailScreen(isSignUp: true));
  }

  Future<void> sendOtp() async {}

  Future<void> verifyOtp() async {}
}
