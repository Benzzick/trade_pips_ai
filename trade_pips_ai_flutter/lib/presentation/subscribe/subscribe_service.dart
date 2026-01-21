import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/endpoints.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';

class SubscribeService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Endpoints.baseUrl;
    super.onInit();
  }

  Future<String?> getCheckoutUrl() async {
    final accessToken =
        Get.find<UserController>().user.value?.accessToken ?? "";

    final getCheckoutUrlResponse = await post(
      Endpoints.getPaymentUrl,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
      {},
    );
    if (getCheckoutUrlResponse.statusCode == 200 ||
        getCheckoutUrlResponse.statusCode == 201) {
      final getCheckoutUrlResponseBody = getCheckoutUrlResponse.body;

      return getCheckoutUrlResponseBody['data']["authorization_url"];
    } else if (getCheckoutUrlResponse.statusCode == 401) {
      await Get.find<UserController>().refreshAccessToken();
      return await getCheckoutUrl();
    } else {
      Get.find<TopSnackBarController>().show(
        message: "Failed to load payment page!",
        success: false,
      );
      return null;
    }
  }
}
