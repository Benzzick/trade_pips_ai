import 'dart:async';

import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/models/news_model.dart';

class NewsController extends GetxController {
  final Rx<DateTime> now = DateTime.now().obs;
  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(seconds: 60), (timer) {
      now.value = DateTime.now();
    });
  }

  final RxList<NewsModel> newsList = <NewsModel>[
    NewsModel(
      time: DateTime.now().subtract(Duration(minutes: 10)),
      currency: "USD",
      title: "Non-Farm Payrolls Released",
      description:
          "The US Non-Farm Payrolls increased by 250K in November, beating expectations.",
      impact: NewsImpact.high,
    ),
    NewsModel(
      time: DateTime.now().subtract(Duration(hours: 2)),
      currency: "EUR",
      title: "ECB Interest Rate Decision",
      description: "European Central Bank raised interest rates by 0.25%.",
      impact: NewsImpact.medium,
    ),
  ].obs;

  final Rx<NewsModel?> breakingNews = NewsModel(
    time: DateTime.now().subtract(Duration(hours: 2)),
    currency: "EUR",
    title: "ECB Interest Rate Decision",
    description:
        "European Central Bank raised interest rates by 0.25%. final text = controller.breakingNews.value.description;",
    impact: NewsImpact.medium,
  ).obs;
}
