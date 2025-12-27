import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/models/signal_model.dart';
import 'package:trade_pips_ai_flutter/models/today_stats_model.dart';

class SignalsController extends GetxController {
  RxList<int> selectedTpIndex = <int>[].obs;
  RxList<int> selectedSlIndex = <int>[].obs;
  Rx<DateTime> now = DateTime.now().obs;
  final RxDouble calculatedLotSize = 0.0.obs;
  final balanceCtrl = TextEditingController();
  final riskCtrl = TextEditingController();

  void calculateLotSize({
    required SignalModel signal,
    required int slIndex,
  }) {
    final balance = double.tryParse(balanceCtrl.text) ?? 0;
    final riskPercent = double.tryParse(riskCtrl.text) ?? 0;

    if (balance <= 0 || riskPercent <= 0 || signal.tickSize <= 0) {
      calculatedLotSize.value = 0;
      return;
    }

    final entry = signal.entryPrice;
    final stopLoss = signal.stopLossPrice[slIndex];
    final stopDistance = (entry - stopLoss).abs();

    if (stopDistance <= 0) {
      calculatedLotSize.value = 0;
      return;
    }

    final riskAmount = balance * (riskPercent / 100);
    final ticks = stopDistance / signal.tickSize;
    final lossPerLot = ticks * signal.tickValue;

    if (lossPerLot <= 0) {
      calculatedLotSize.value = 0;
      return;
    }

    double lot = riskAmount / lossPerLot;

    final stepFactor = (1.0 / signal.lotStep).round();
    lot = (lot * stepFactor).floorToDouble() / stepFactor;

    if (lot < signal.minLot && lot > 0) lot = signal.minLot;
    if (lot > signal.maxLot) lot = signal.maxLot;

    calculatedLotSize.value = lot;
  }

  @override
  void onInit() {
    super.onInit();
    selectedTpIndex.value = List.filled(signals.length, 0);
    selectedSlIndex.value = List.filled(signals.length, 0);
    Timer.periodic(Duration(seconds: 60), (timer) {
      now.value = DateTime.now();
    });
  }

  final RxList<TodayStatsModel> todaystats = <TodayStatsModel>[
    TodayStatsModel(numberPercent: "74%", title: "Win Rate"),
    TodayStatsModel(numberPercent: "68%", title: "Avg Prob"),
    TodayStatsModel(numberPercent: "24", title: "Today"),
  ].obs;
  final List<Color> statBgColors = [
    const Color.fromARGB(255, 30, 255, 0),
    const Color.fromARGB(255, 255, 0, 179),
    const Color.fromARGB(255, 0, 255, 255),
  ];

  RxInt selectedSignalIndex = 0.obs;

  Map<String, List<SignalModel>> get uniqueStrategies {
    final Map<String, List<SignalModel>> result = {};

    for (final signal in signals) {
      final strategy = signal.strategy.trim();

      if (!result.containsKey(strategy)) {
        result[strategy] = [];
      }

      result[strategy]!.add(signal);
    }

    return result;
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

  final RxList<SignalModel> signals = <SignalModel>[
    // ===== BREAKOUT STRATEGY =====
    SignalModel(
      direction: SignalDirection.buy,
      pair: "EUR/USD",
      strategy: "Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 5)),
      targetPips: 40,
      timeFrame: "M15",
      probability: 78,
      entryPrice: 1.0925,
      takeProfitPrice: [1.0945, 1.0965, 1.0990],
      stopLossPrice: [1.0905, 1.0895],
      contractSize: 100000,
      tickSize: 0.0001,
      tickValue: 10,
      minLot: 0.01,
      lotStep: 0.01,
      maxLot: 100,
      isIndex: false,
    ),
    SignalModel(
      direction: SignalDirection.sell,
      pair: "GBP/USD",
      strategy: "Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 12)),
      targetPips: 35,
      timeFrame: "M15",
      probability: 75,
      entryPrice: 1.2650,
      takeProfitPrice: [1.2625, 1.2605],
      stopLossPrice: [1.2670, 1.2680],
      contractSize: 100000,
      tickSize: 0.0001,
      tickValue: 10,
      minLot: 0.01,
      lotStep: 0.01,
      maxLot: 100,
      isIndex: false,
    ),
    SignalModel(
      direction: SignalDirection.buy,
      pair: "USD/JPY",
      strategy: "Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 18)),
      targetPips: 50,
      timeFrame: "M30",
      probability: 80,
      entryPrice: 149.20,
      takeProfitPrice: [149.50, 149.70, 150.00],
      stopLossPrice: [148.95, 148.80],
      contractSize: 100000,
      tickSize: 0.01,
      tickValue: 9.5,
      minLot: 0.01,
      lotStep: 0.01,
      maxLot: 100,
      isIndex: false,
    ),

    // ===== TREND REVERSAL STRATEGY =====
    SignalModel(
      direction: SignalDirection.sell,
      pair: "XAU/USD",
      strategy: "Trend Reversal",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 20)),
      targetPips: 15,
      timeFrame: "H1",
      probability: 72,
      entryPrice: 1905.50,
      takeProfitPrice: [1895.50, 1890.00],
      stopLossPrice: [1910.00, 1915.00],
      contractSize: 100,
      tickSize: 0.01,
      tickValue: 1,
      minLot: 0.01,
      lotStep: 0.01,
      maxLot: 10,
      isIndex: false,
    ),
    SignalModel(
      direction: SignalDirection.buy,
      pair: "XAG/USD",
      strategy: "Trend Reversal",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 25)),
      targetPips: 25,
      timeFrame: "H1",
      probability: 74,
      entryPrice: 25.10,
      takeProfitPrice: [25.35, 25.50],
      stopLossPrice: [24.90, 24.80],
      contractSize: 5000,
      tickSize: 0.01,
      tickValue: 0.5,
      minLot: 0.01,
      lotStep: 0.01,
      maxLot: 10,
      isIndex: false,
    ),

    // ===== SUPPORT BOUNCE STRATEGY =====
    SignalModel(
      direction: SignalDirection.buy,
      pair: "BTC/USD",
      strategy: "Support Bounce",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 30)),
      targetPips: 500,
      timeFrame: "H4",
      probability: 81,
      entryPrice: 50000,
      takeProfitPrice: [50500, 51000, 51500],
      stopLossPrice: [49500, 49000],
      contractSize: 1,
      tickSize: 1,
      tickValue: 1,
      minLot: 0.0001,
      lotStep: 0.0001,
      maxLot: 10,
      isIndex: false,
    ),
    SignalModel(
      direction: SignalDirection.sell,
      pair: "ETH/USD",
      strategy: "Support Bounce",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 35)),
      targetPips: 50,
      timeFrame: "H4",
      probability: 79,
      entryPrice: 4000,
      takeProfitPrice: [3950, 3900, 3850],
      stopLossPrice: [4050, 4100],
      contractSize: 1,
      tickSize: 0.01,
      tickValue: 0.01,
      minLot: 0.001,
      lotStep: 0.001,
      maxLot: 10,
      isIndex: false,
    ),

    // ===== BREAKOUT STRATEGY (INDICES) =====
    SignalModel(
      direction: SignalDirection.buy,
      pair: "NAS100",
      strategy: "Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 40)),
      targetPips: 30,
      timeFrame: "M30",
      probability: 77,
      entryPrice: 16000,
      takeProfitPrice: [16030, 16060],
      stopLossPrice: [15970, 15950],
      contractSize: 1,
      tickSize: 1,
      tickValue: 1,
      minLot: 0.01,
      lotStep: 0.01,
      maxLot: 5,
      isIndex: true,
    ),
    SignalModel(
      direction: SignalDirection.sell,
      pair: "US30",
      strategy: "Breakout",
      timeGotSignal: DateTime.now().subtract(const Duration(minutes: 45)),
      targetPips: 40,
      timeFrame: "M30",
      probability: 76,
      entryPrice: 33000,
      takeProfitPrice: [32960, 32920],
      stopLossPrice: [33040, 33080],
      contractSize: 1,
      tickSize: 1,
      tickValue: 1,
      minLot: 0.01,
      lotStep: 0.01,
      maxLot: 5,
      isIndex: true,
    ),
  ].obs;
}
