import 'dart:math';

import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/models/candle_data_model.dart';
import 'package:trade_pips_ai_flutter/models/chart_pair_model.dart';

class ChartsController extends GetxController {
  final RxList<CandleDataModel> chartData = <CandleDataModel>[].obs;
  final RxList<ChartPairModel> chartPairs = <ChartPairModel>[
    // ===== FOREX =====
    ChartPairModel(pair: "EUR/USD", timeframe: "M15"),
    ChartPairModel(pair: "GBP/USD", timeframe: "M15"),
    ChartPairModel(pair: "USD/JPY", timeframe: "M15"),
    ChartPairModel(pair: "AUD/USD", timeframe: "M15"),
    ChartPairModel(pair: "USD/CHF", timeframe: "M15"),
    ChartPairModel(pair: "NZD/USD", timeframe: "M15"),
    ChartPairModel(pair: "EUR/GBP", timeframe: "M15"),
    ChartPairModel(pair: "EUR/JPY", timeframe: "M15"),

    // ===== METALS =====
    ChartPairModel(pair: "XAU/USD", timeframe: "M15"),
    ChartPairModel(pair: "XAG/USD", timeframe: "M15"),

    // ===== CRYPTO =====
    ChartPairModel(pair: "BTC/USD", timeframe: "M15"),
    ChartPairModel(pair: "ETH/USD", timeframe: "M15"),
    ChartPairModel(pair: "LTC/USD", timeframe: "M15"),
    ChartPairModel(pair: "BNB/USD", timeframe: "M15"),
    ChartPairModel(pair: "SOL/USD", timeframe: "M15"),

    // ===== INDICES =====
    ChartPairModel(pair: "US30", timeframe: "M15"),
    ChartPairModel(pair: "NAS100", timeframe: "M15"),
    ChartPairModel(pair: "SPX500", timeframe: "M15"),
    ChartPairModel(pair: "DAX30", timeframe: "M15"),
    ChartPairModel(pair: "FTSE100", timeframe: "M15"),

    // ===== MORE PAIRS =====
    ChartPairModel(pair: "EUR/CAD", timeframe: "M15"),
    ChartPairModel(pair: "GBP/JPY", timeframe: "M15"),
    ChartPairModel(pair: "AUD/JPY", timeframe: "M15"),
    ChartPairModel(pair: "USD/CAD", timeframe: "M15"),
    ChartPairModel(pair: "EUR/CHF", timeframe: "M15"),
    ChartPairModel(pair: "GBP/CHF", timeframe: "M15"),
    ChartPairModel(pair: "NZD/JPY", timeframe: "M15"),
    ChartPairModel(pair: "BTC/EUR", timeframe: "M15"),
    ChartPairModel(pair: "ETH/EUR", timeframe: "M15"),
    ChartPairModel(pair: "XAU/EUR", timeframe: "M15"),
    ChartPairModel(pair: "XAG/EUR", timeframe: "M15"),
    ChartPairModel(pair: "US500", timeframe: "M15"),
    ChartPairModel(pair: "JP225", timeframe: "M15"),
    ChartPairModel(pair: "HK50", timeframe: "M15"),
    ChartPairModel(pair: "AUS200", timeframe: "M15"),
    ChartPairModel(pair: "CAD/JPY", timeframe: "M15"),
    ChartPairModel(pair: "EUR/NZD", timeframe: "M15"),
    ChartPairModel(pair: "GBP/NZD", timeframe: "M15"),
    ChartPairModel(pair: "AUD/NZD", timeframe: "M15"),
    ChartPairModel(pair: "ETH/BTC", timeframe: "M15"),
    ChartPairModel(pair: "SOL/BTC", timeframe: "M15"),
    ChartPairModel(pair: "BNB/BTC", timeframe: "M15"),
    ChartPairModel(pair: "LTC/BTC", timeframe: "M15"),
    ChartPairModel(pair: "DOGE/USD", timeframe: "M15"),
  ].obs;

  final RxInt selectedChartPairIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    generateChartData(chartPairs[0]);
  }

  void generateChartData(ChartPairModel chartPair) {
    chartData.clear();
    final random = Random();
    double lastClose = 1.0920; // starting price

    for (int i = 0; i < 10000; i++) {
      // Simulate price movements
      double open = lastClose;
      double high = open + random.nextDouble() * 0.0020; // up to +20 pips
      double low = open - random.nextDouble() * 0.0020; // down to -20 pips
      double close = low + random.nextDouble() * (high - low);

      chartData.add(
        CandleDataModel(
          time: DateTime.now().subtract(Duration(minutes: 15 * (50 - i))),
          open: double.parse(open.toStringAsFixed(4)),
          high: double.parse(high.toStringAsFixed(4)),
          low: double.parse(low.toStringAsFixed(4)),
          close: double.parse(close.toStringAsFixed(4)),
        ),
      );

      lastClose = close;
    }
  }
}
