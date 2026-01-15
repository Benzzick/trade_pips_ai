import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trade_pips_ai_flutter/core/constants/endpoints.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';
import 'package:trade_pips_ai_flutter/models/user_model.dart';

class AuthService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Endpoints.baseUrl;
    super.onInit();
  }

  Future<bool> registerWithEmail(
    String email,
    String password,
    String otp,
  ) async {
    final requestBody = {'email': email, 'password': password, 'otp': otp};
    final response = await post(Endpoints.register, requestBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Registered successfully",
        success: true,
      );

      final loggedIn = await loginWithEmail(email, password);
      if (loggedIn) {
        return true;
      } else {
        return false;
      }
    } else {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Registration failed",
        success: false,
      );
      return false;
    }
  }

  Future<bool> sendOtpToCreateAccount(String email) async {
    final requestBody = {'email': email};
    final response = await post(Endpoints.verifyEmail, requestBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "OTP Sent!",
        success: true,
      );
      return true;
    } else {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Failed to send OTP!",
        success: false,
      );
      return false;
    }
  }

  Future<bool> sendOtpToResetPassword(String email) async {
    final requestBody = {'email': email};
    final response = await post(Endpoints.passwordReset, requestBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Password reset token sent!",
        success: true,
      );
      return true;
    } else {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Failed to send password reset token!",
        success: false,
      );
      return false;
    }
  }

  Future<bool> confirmPasswordReset(String token, String password) async {
    final requestBody = {'token': token, 'password': password};
    final response = await post(Endpoints.passwordResetConfirm, requestBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Password changed!",
        success: true,
      );
      return true;
    } else {
      final responseBody = response.body;

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Failed to change password!",
        success: false,
      );
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            "69097857789-97vh9lacqvfih5ctbjf8dvfkilelhdh5.apps.googleusercontent.com",
      );

      final GoogleSignInAccount user = await GoogleSignIn.instance
          .authenticate();
      final idToken = user.authentication.idToken;
      if (idToken == null) throw Exception();

      final requestBody = {"id_token": idToken};
      final response = await post(Endpoints.loginWithGoogle, requestBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.body;

        final accessToken = responseBody["access"] as String;
        final refreshToken = responseBody["refresh"] as String;

        final getProfileResponse = await get(
          Endpoints.getProfile,
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        );

        if (getProfileResponse.statusCode == 200 ||
            getProfileResponse.statusCode == 201) {
          final profileBody = getProfileResponse.body;

          profileBody['accessToken'] = accessToken;
          profileBody['refreshToken'] = refreshToken;

          final user = UserModel.fromJson(profileBody);
          final String? token;
          try {
            token = await FirebaseMessaging.instance.getToken();
          } catch (e) {
            return false;
          }

          print("$token bbjnsbdjenkjndkjnd");

          final sendFcmTokenResponse = await post(
            Endpoints.getFcmToken,
            headers: {
              "Authorization": "Bearer $accessToken",
            },
            {
              "token": token,
              "platform": "android",
            },
          );

          if (sendFcmTokenResponse.statusCode == 200 ||
              sendFcmTokenResponse.statusCode == 201) {
            final userController = Get.find<UserController>();
            userController.saveUser(user);
            Get.find<TopSnackBarController>().show(
              message: "Login successfull!",
              success: true,
            );
            return true;
          } else {
            throw Exception(sendFcmTokenResponse.body);
          }
        } else {
          throw Exception(getProfileResponse.body);
        }
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      Get.find<TopSnackBarController>().show(
        message:
            "Failed to sign in with Google. Check your internet and try again!",
        success: false,
      );
      return false;
    }
  }

  Future<bool> loginWithEmail(String email, String password) async {
    final requestBody = {'username': email, 'password': password};
    final response = await post(Endpoints.login, requestBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = response.body;

      final accessToken = responseBody["access"] as String;
      final refreshToken = responseBody["refresh"] as String;

      final getProfileResponse = await get(
        Endpoints.getProfile,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (getProfileResponse.statusCode == 200 ||
          getProfileResponse.statusCode == 201) {
        final profileBody = getProfileResponse.body;

        profileBody['accessToken'] = accessToken;
        profileBody['refreshToken'] = refreshToken;

        final user = UserModel.fromJson(profileBody);

        final token = await FirebaseMessaging.instance.getToken();

        final sendFcmTokenResponse = await post(
          Endpoints.getFcmToken,
          headers: {
            "Authorization": "Bearer $accessToken",
          },
          {
            "token": token,
            "platform": "android",
          },
        );
        if (sendFcmTokenResponse.statusCode == 200 ||
            sendFcmTokenResponse.statusCode == 201) {
          final userController = Get.find<UserController>();
          userController.saveUser(user);
          Get.find<TopSnackBarController>().show(
            message: "Login successfull!",
            success: true,
          );
          return true;
        } else {
          Get.find<TopSnackBarController>().show(
            message: "Failed to login. Try again!",
            success: false,
          );
          return false;
        }
      } else {
        Get.find<TopSnackBarController>().show(
          message: "Failed to fetch user profile",
          success: false,
        );
        return false;
      }
    } else {
      final responseBody = response.body;

      print(responseBody);

      Get.find<TopSnackBarController>().show(
        message: responseBody is Map
            ? responseBody.values.first.toString()
            : "Login failed",
        success: false,
      );
      return false;
    }
  }
}
