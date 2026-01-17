import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/endpoints.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';

class UserService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Endpoints.baseUrl;
    super.onInit();
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    final refreshAccessTokenResponse = await post(
      Endpoints.refreshToken,
      {
        "refresh": refreshToken,
      },
    );
    if (refreshAccessTokenResponse.statusCode == 200 ||
        refreshAccessTokenResponse.statusCode == 201) {
      final refreshAccessTokenResponseBody = refreshAccessTokenResponse.body;
      final accessToken = refreshAccessTokenResponseBody["access"] as String;

      return accessToken;
    } else {
      return null;
    }
  }

  Future<bool> saveUserData({
    String? name,
    String? email,
    bool? enablePushNotifications,
    bool? enableNewsUpdates,
  }) async {
    final accessToken =
        Get.find<UserController>().user.value?.accessToken ?? "";

    final saveUserDataResponse = await post(
      Endpoints.toggleNotifications,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      {},
    );

    if (saveUserDataResponse.statusCode == 200 ||
        saveUserDataResponse.statusCode == 201) {
      return true;
    }

    if (saveUserDataResponse.statusCode == 401) {
      await Get.find<UserController>().refreshAccessToken();
      return await saveUserData(
        name: name,
        email: email,
        enablePushNotifications: enablePushNotifications,
        enableNewsUpdates: enableNewsUpdates,
      );
    }
    return false;
  }
}
