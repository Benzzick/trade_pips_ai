import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/endpoints.dart';

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
}
