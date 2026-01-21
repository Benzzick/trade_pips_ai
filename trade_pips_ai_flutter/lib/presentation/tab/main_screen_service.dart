import 'dart:math';

import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/constants/endpoints.dart';
import 'package:trade_pips_ai_flutter/core/controllers/user_controller.dart';
import 'package:trade_pips_ai_flutter/models/news_model.dart';
import 'package:trade_pips_ai_flutter/models/signal_model.dart';
import 'package:trade_pips_ai_flutter/models/today_stats_model.dart';
import 'package:trade_pips_ai_flutter/presentation/news/news_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/notifications/notifications_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/signals/signals_controller.dart';
import 'package:trade_pips_ai_flutter/presentation/charts/charts_controller.dart';
import 'package:trade_pips_ai_flutter/models/chart_pair_model.dart';

class MainScreenService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Endpoints.baseUrl;
    super.onInit();
  }

  /// Fetch dashboard: signals, stats, news + chart pairs
  Future<bool?> getMainScreenData(bool hasLoaded) async {
    final accessToken =
        Get.find<UserController>().user.value?.accessToken ?? "";

    try {
      final response = await get(
        Endpoints.signals,
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        if (response.body == null || response.body is! Map) {
          // Treat empty or invalid body as empty dashboard (NOT error)
          _commitEmptyDashboard();
          return true;
        }

        final Map<String, dynamic> data = Map<String, dynamic>.from(
          response.body,
        );

        // ---------------- SAFE PARSING ----------------

        // Signals
        final List signalsJson = (data['signals'] is List)
            ? data['signals']
            : [];

        final signals = signalsJson
            .map((e) => SignalModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        // Stats
        final statsJson = (data['stats'] is Map)
            ? Map<String, dynamic>.from(data['stats'])
            : {};

        final winRate = _num(statsJson['win_rate']);
        final avgProb = _num(statsJson['avg_probability']);
        final today = _num(statsJson['signals_today']);

        final stats = [
          TodayStatsModel(
            numberPercent: "${winRate.toInt()}%",
            title: "Win Rate",
          ),
          TodayStatsModel(
            numberPercent: "${avgProb.toStringAsFixed(1)}%",
            title: "Avg Prob",
          ),
          TodayStatsModel(
            numberPercent: "${today.toInt()}",
            title: "Today",
          ),
        ];

        // News
        final List newsJson = (data['news'] is List) ? data['news'] : [];

        final news = newsJson
            .map((e) => NewsModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        final breakingNews = news.isNotEmpty
            ? news[Random().nextInt(news.length)]
            : null;

        // ---------------- FETCH NOTIFICATIONS ----------------
        final notifications = await fetchNotificationsOrNull();
        if (notifications == null) {
          if (!hasLoaded) _resetAll();
          return false;
        }

        // ---------------- FETCH CHART PAIRS ----------------
        final pairs = await fetchChartPairsOrNull();
        if (pairs == null) {
          if (!hasLoaded) _resetAll();
          return false;
        }

        // ---------------- FETCH CHART PAIRS ----------------
        final enabledPushNotifications =
            await fetchEnabledPushNotificationsOrNull();
        if (enabledPushNotifications == null) {
          if (!hasLoaded) _resetAll();
          return false;
        }

        // ---------------- ATOMIC COMMIT ----------------
        Get.find<SignalsController>().signals.value = signals;
        Get.find<SignalsController>().todaystats.value = stats;
        Get.find<NewsController>().newsList.value = news;
        Get.find<NewsController>().breakingNews.value = breakingNews;
        Get.find<ChartsController>().chartPairs.assignAll(pairs);
        Get.find<NotificationsController>().notifications.value = notifications;
        Get.find<UserController>().saveUser(
          Get.find<UserController>().user.value!.copyWith(
            enablePushNotifications: enabledPushNotifications,
          ),
        );

        return true;
      }

      // -------- AUTH --------
      if (response.statusCode == 401) {
        await Get.find<UserController>().refreshAccessToken();
        return await getMainScreenData(hasLoaded);
      }

      // -------- AUTH --------
      if (response.statusCode == 403) {
        return null;
      }

      // -------- OTHER ERRORS --------
      if (!hasLoaded) _resetAll();
      return false;
    } catch (e) {
      print("getMainScreenData error: $e");
      if (!hasLoaded) _resetAll();
      return false;
    }
  }

  double _num(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0;
    return 0;
  }

  void _commitEmptyDashboard() {
    Get.find<SignalsController>().signals.clear();
    Get.find<SignalsController>().todaystats.value = const [
      TodayStatsModel(numberPercent: "0%", title: "Win Rate"),
      TodayStatsModel(numberPercent: "0%", title: "Avg Prob"),
      TodayStatsModel(numberPercent: "0", title: "Today"),
    ];
    Get.find<NewsController>().newsList.clear();
    Get.find<NewsController>().breakingNews.value = null;
  }

  /// Fetch chart pairs. Returns NULL if failed.
  Future<List<ChartPairModel>?> fetchChartPairsOrNull() async {
    final accessToken =
        Get.find<UserController>().user.value?.accessToken ?? "";

    try {
      final response = await get(
        Endpoints.pairs,
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final data = response.body as Map<String, dynamic>;
        final List<dynamic> pairsJson = data['pairs'] ?? [];

        return pairsJson
            .map((p) => ChartPairModel(pair: p.toString(), timeframe: 'M15'))
            .toList();
      } else if (response.statusCode == 401) {
        // Try refreshing token once
        final refreshed = await Get.find<UserController>().refreshAccessToken();
        if (!refreshed) return null;
        return null; // Do NOT retry fetching again
      } else {
        // Any other error, just return null
        return null;
      }
    } catch (e) {
      print("fetchChartPairsOrNull error: $e");
      return null;
    }
  }

  Future<bool?> fetchEnabledPushNotificationsOrNull() async {
    final accessToken =
        Get.find<UserController>().user.value?.accessToken ?? "";

    try {
      final getProfileResponse = await get(
        Endpoints.getProfile,
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (getProfileResponse.statusCode == 200) {
        final profileBody = getProfileResponse.body;

        return profileBody['push_notifications'] as bool;
      } else if (getProfileResponse.statusCode == 401) {
        // Try refreshing token once
        final refreshed = await Get.find<UserController>().refreshAccessToken();
        if (!refreshed) return null;
        return null; // Do NOT retry fetching again
      } else {
        // Any other error, just return null
        return null;
      }
    } catch (e) {
      print("fetchEnabledPushNotificationsOrNull error: $e");
      return null;
    }
  }

  Future<List<NotificationModel>?> fetchNotificationsOrNull() async {
    final accessToken =
        Get.find<UserController>().user.value?.accessToken ?? "";

    try {
      final response = await get(
        Endpoints.inAppNotifications,
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final data = response.body as Map<String, dynamic>;
        final List<dynamic> notificationsJson = data['notifications'] ?? [];

        return notificationsJson
            .map(
              (p) => NotificationModel(
                direction: p["direction"],
                pair: p["pair"],
                strategy: p['strategy'],
                timeGotSignal: p['timeGotSignal'],
                targetPips: p['targetPips'],
                timeFrame: p['timeFrame'],
                probability: p['probability'],
                entryPrice: p['entryPrice'],
                takeProfitPrice: p['takeProfitPrice'],
                stopLossPrice: p['stopLossPrice'],
              ),
            )
            .toList();
      } else if (response.statusCode == 401) {
        // Try refreshing token once
        final refreshed = await Get.find<UserController>().refreshAccessToken();
        if (!refreshed) return null;
        return null; // Do NOT retry fetching again
      } else if (response.statusCode == 404) {
        return [];
      } else {
        // Any other error, just return null
        return null;
      }
    } catch (e) {
      print("fetchNotificationsOrNull error: $e");
      return null;
    }
  }

  /// Clear EVERYTHING if something critical fails
  void _resetAll() {
    Get.find<SignalsController>().signals.clear();
    Get.find<SignalsController>().todaystats.clear();
    Get.find<NewsController>().newsList.clear();
    Get.find<NewsController>().breakingNews.value = null;
    Get.find<ChartsController>().chartPairs.clear();
  }
}
