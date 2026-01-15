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

  String mapTimeframe(String tf) {
    switch (tf) {
      case 'M1':
        return '1';
      case 'M5':
        return '5';
      case 'M15':
        return '15';
      case 'H1':
        return '60';
      case 'H4':
        return '240';
      case 'D1':
        return 'D';
      default:
        return '15';
    }
  }

  String tradingViewHtml({
    required String symbol,
    required String interval,
    bool darkMode = false,
  }) {
    String mappedInterval = mapTimeframe(interval);

    return '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
    <style>
    html, body {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;
      overflow: hidden; /* 🚫 Kill scrollbars */
      background-color: ${darkMode ? '#000000' : '#ffffff'};
    }

    #tradingview_chart {
      position: fixed;
      inset: 0; /* top:0; right:0; bottom:0; left:0 */
      width: 100vw;
      height: 100vh;
      overflow: hidden;
    }
  </style>
  </head>
  <body style="margin:0;height:100vh;background-color:${darkMode ? '#000000' : '#ffffff'};">
    <div id="tradingview_chart" style="width:100%;height:100%;"></div>
    <script type="text/javascript">
      const localTimezone = Intl.DateTimeFormat().resolvedOptions().timeZone;

      new TradingView.widget({
        "container_id": "tradingview_chart",
        "autosize": true,
        "symbol": "$symbol",
        "interval": "$mappedInterval",
        "timezone": localTimezone,
        "theme": "${darkMode ? 'dark' : 'light'}",
        "style": "1",
        "locale": "en",
        "hide_top_toolbar": true,
        "allow_symbol_change": false,
        // "studies": ["MASimple@tv-basicstudies", "RSI@tv-basicstudies"], 
        "withdateranges": false,
        "details": false,
        "readonly": true
      });
    </script>
  </body>
</html>
''';
  }
}
