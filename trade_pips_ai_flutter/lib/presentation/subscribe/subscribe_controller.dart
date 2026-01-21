import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/controllers/top_snack_bar_controller.dart';
import 'package:trade_pips_ai_flutter/models/subscription_model.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/paystack_screen.dart';
import 'package:trade_pips_ai_flutter/presentation/subscribe/subscribe_service.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';

class SubscribeController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<SubscriptionModel?> subModel = const SubscriptionModel(
    subName: "Premium Plan",
    price: 29.99,
    duration: "Monthly",
    thingsToGet: [
      "Unlimited FX Signals",
      "AI Probability Analysis",
      "Risk Management Calculator",
      "Breaking Market News",
      "Priority Notifications",
    ],
  ).obs;

  final RxString tutYTVideoId = 'qdW35gIqBSc'.obs;
  final RxString tutYTVideoHeader =
      'Watch how beginners use TradePips AI to catch high-probability trades 💵.'
          .obs;

  Future<void> loadSubscriptionPage() async {
    isLoading.value = true;
    final subPageUrl = await Get.find<SubscribeService>().getCheckoutUrl();

    if (subPageUrl == null) return;

    final result = await Get.to(
      () => PaystackScreen(url: subPageUrl),
    );

    if (result == true) {
      Get.find<TopSnackBarController>().show(
        message: "Payment completed!",
        success: true,
      );
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.find<TopSnackBarController>().show(
        message: "Payment was cancelled! Try again!",
        success: false,
      );
    }
    isLoading.value = false;
  }

  void loadSubModel() {}
}
