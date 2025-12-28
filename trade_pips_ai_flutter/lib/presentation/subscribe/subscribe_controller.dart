import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/models/subscription_model.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';

class SubscribeController extends GetxController {
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

  void subscribe() {
    Get.offAllNamed(AppRoutes.main);
  }

  void loadSubModel() {}
}
