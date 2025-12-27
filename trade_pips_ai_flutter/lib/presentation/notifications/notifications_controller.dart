import 'dart:async';

import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/models/signal_model.dart';

class NotificationsController extends GetxController {
  final Rx<DateTime> now = DateTime.now().obs;
  final RxList<NotificationModel> notifications = <NotificationModel>[
    // ===== FOREX =====
    NotificationModel(
      direction: SignalDirection.buy,
      pair: "EUR/USD",
      strategy: "Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 3)),
      targetPips: 35,
      timeFrame: "M15",
      probability: 78,
      entryPrice: 1.0932,
      takeProfitPrice: 1.0967,
      stopLossPrice: 1.0912,
    ),
    NotificationModel(
      direction: SignalDirection.sell,
      pair: "GBP/USD",
      strategy: "Trend Reversal",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 8)),
      targetPips: 40,
      timeFrame: "M30",
      probability: 74,
      entryPrice: 1.2658,
      takeProfitPrice: 1.2618,
      stopLossPrice: 1.2685,
    ),
    NotificationModel(
      direction: SignalDirection.buy,
      pair: "USD/JPY",
      strategy: "Support Bounce",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 14)),
      targetPips: 50,
      timeFrame: "H1",
      probability: 81,
      entryPrice: 149.25,
      takeProfitPrice: 149.75,
      stopLossPrice: 148.90,
    ),

    // ===== METALS =====
    NotificationModel(
      direction: SignalDirection.sell,
      pair: "XAU/USD",
      strategy: "Liquidity Sweep",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 20)),
      targetPips: 150,
      timeFrame: "M30",
      probability: 76,
      entryPrice: 1912.40,
      takeProfitPrice: 1897.00,
      stopLossPrice: 1920.50,
    ),
    NotificationModel(
      direction: SignalDirection.buy,
      pair: "XAG/USD",
      strategy: "Trend Continuation",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 27)),
      targetPips: 80,
      timeFrame: "H1",
      probability: 73,
      entryPrice: 25.10,
      takeProfitPrice: 25.90,
      stopLossPrice: 24.70,
    ),

    // ===== CRYPTO =====
    NotificationModel(
      direction: SignalDirection.buy,
      pair: "BTC/USD",
      strategy: "Range Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 35)),
      targetPips: 1200,
      timeFrame: "H4",
      probability: 82,
      entryPrice: 50250,
      takeProfitPrice: 51450,
      stopLossPrice: 49500,
    ),
    NotificationModel(
      direction: SignalDirection.sell,
      pair: "ETH/USD",
      strategy: "Lower High Rejection",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 42)),
      targetPips: 180,
      timeFrame: "H1",
      probability: 77,
      entryPrice: 4020,
      takeProfitPrice: 3840,
      stopLossPrice: 4105,
    ),

    // ===== INDICES =====
    NotificationModel(
      direction: SignalDirection.buy,
      pair: "NAS100",
      strategy: "Opening Range Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 50)),
      targetPips: 45,
      timeFrame: "M15",
      probability: 79,
      entryPrice: 16010,
      takeProfitPrice: 16055,
      stopLossPrice: 15970,
    ),
    NotificationModel(
      direction: SignalDirection.sell,
      pair: "US30",
      strategy: "Trend Exhaustion",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 58)),
      targetPips: 60,
      timeFrame: "M30",
      probability: 75,
      entryPrice: 33020,
      takeProfitPrice: 32960,
      stopLossPrice: 33085,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(seconds: 60), (timer) {
      now.value = DateTime.now();
    });
  }

  String getStrategyAbbreviation(String strategy) {
    final trimmed = strategy.trim();

    if (trimmed.contains(' ')) {
      final parts = trimmed.split(RegExp(r'\s+'));
      return (parts[0][0] + parts[1][0]).toUpperCase();
    } else {
      return trimmed.length >= 2
          ? trimmed.substring(0, 2).toUpperCase()
          : trimmed.toUpperCase();
    }
  }

  String probabilityLabel(int probability) {
    if (probability >= 85) {
      return "Very High Probability";
    } else if (probability >= 70) {
      return "High Probability";
    } else if (probability >= 55) {
      return "Medium Probability";
    } else if (probability >= 40) {
      return "Low Probability";
    } else {
      return "Very Low Probability";
    }
  }
}
