import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/auth_service.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/change_password_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/success_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/auth/verify_email_screen.dart';

class AuthController extends GetxController {
  final RxBool seePassword = true.obs;
  final RxBool isLogin = true.obs;
  final RxString otp = ''.obs;
  final RxBool isLoading = false.obs;

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController passwordResetTokenCtrl = TextEditingController();

  final RxInt resendSeconds = 0.obs;
  final RxBool canResend = true.obs;

  Timer? _resendTimer;

  void startResendTimer() {
    resendSeconds.value = 30;
    canResend.value = false;

    _resendTimer?.cancel();

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value == 0) {
        timer.cancel();
        canResend.value = true;
      } else {
        resendSeconds.value--;
      }
    });
  }

  void addOtp(String value) {
    if (otp.value.length < 6) {
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
    isLoading.value = true;

    final loggedIn = await Get.find<AuthService>().loginWithGoogle();

    if (loggedIn) Get.offAll(SuccessScreen());

    isLoading.value = false;
  }

  Future<void> loginWithEmail() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text;

    if (email.isEmpty || password.isEmpty) {
      _showError("Please fill in all fields");
      return;
    }

    if (!_isEmailValid(email)) {
      _showError("Enter a valid email address");
      return;
    }

    if (!_isPasswordStrong(password)) {
      _showError("Password must be at least 6 characters");
      return;
    }

    isLoading.value = true;

    final loggedIn = await Get.find<AuthService>().loginWithEmail(
      email,
      password,
    );

    if (loggedIn) Get.offAll(SuccessScreen());

    isLoading.value = false;
  }

  // Future<void> loginWithEmail() async {
  //   final userController = Get.find<UserController>();
  //   if (DateTime.now().isBefore(
  //     userController.user.value.subscriptionEndDate,
  //   )) {
  //     Get.offAllNamed(AppRoutes.main);
  //   } else {
  //     Get.offAllNamed(AppRoutes.subscribe);
  //   }
  // }

  Future<void> createAccount() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text;

    isLoading.value = true;

    // ✅ Call API
    final registered = await Get.find<AuthService>().registerWithEmail(
      email,
      password,
      otp.value,
    );

    if (registered) Get.offAll(SuccessScreen());

    isLoading.value = false;

    // ✅ Navigate only if valid
    // Get.to(() => VerifyEmailScreen(isSignUp: true));
  }

  Future<void> sendOtpToCreateAccount() async {
    otp.value = '';
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text;
    final confirm = confirmPasswordCtrl.text;

    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showError("Please fill in all fields");
      return;
    }

    if (!_isEmailValid(email)) {
      _showError("Enter a valid email address");
      return;
    }

    if (!_isPasswordStrong(password)) {
      _showError("Password must be at least 6 characters");
      return;
    }

    if (password != confirm) {
      _showError("Passwords do not match");
      return;
    }

    isLoading.value = true;

    final sentOtp = await Get.find<AuthService>().sendOtpToCreateAccount(email);
    if (sentOtp) {
      Get.to(VerifyEmailScreen());
    }

    isLoading.value = false;

    startResendTimer();
  }

  Future<void> sendOtpToResetPassword() async {
    final email = emailCtrl.text.trim();

    if (email.isEmpty) {
      _showError("Please fill in all fields");
      return;
    }

    if (!_isEmailValid(email)) {
      _showError("Enter a valid email address");
      return;
    }

    isLoading.value = true;

    final sentToken = await Get.find<AuthService>().sendOtpToResetPassword(
      email,
    );
    if (sentToken) {
      Get.to(ChangePasswordScreen());
    }

    isLoading.value = false;

    startResendTimer();
  }

  Future<void> confirmPasswordReset() async {
    final password = passwordCtrl.text;
    final confirm = confirmPasswordCtrl.text;
    final token = passwordResetTokenCtrl.text;
    final email = emailCtrl.text.trim();
    if (token.isEmpty || password.isEmpty || confirm.isEmpty || email.isEmpty) {
      _showError("Please fill in all fields");
      return;
    }
    if (!_isEmailValid(email)) {
      _showError("Enter a valid email address");
      return;
    }
    if (!_isPasswordStrong(password)) {
      _showError("Password must be at least 6 characters");
      return;
    }

    if (password != confirm) {
      _showError("Passwords do not match");
      return;
    }

    isLoading.value = true;

    // ✅ Call API
    final changedPassword = await Get.find<AuthService>().confirmPasswordReset(
      token,
      password,
    );

    if (!changedPassword) {
      isLoading.value = false;
      return;
    }

    final loggedIn = await Get.find<AuthService>().loginWithEmail(
      email,
      password,
    );

    if (loggedIn) {
      Get.offAll(SuccessScreen());
    } else {
      isLogin.value = true;
      Get.find<TopSnackBarController>().show(
        message: 'Login!',
        success: false,
      );
      Get.offAll(AuthScreen());
    }

    isLoading.value = false;
  }

  bool _isEmailValid(String email) {
    return GetUtils.isEmail(email.trim());
  }

  bool _isPasswordStrong(String password) {
    return password.length >= 6;
  }

  void _showError(String msg) {
    Get.find<TopSnackBarController>().show(
      message: msg,
      success: false,
    );
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    _resendTimer?.cancel();
    super.onClose();
  }
}
