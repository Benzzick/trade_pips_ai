import 'dart:async';

import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/presentation/tab/main_screen_service.dart';
import 'package:trade_pips_ai_flutter/routes/app_pages.dart';

class MainScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isLoading = false.obs;
  Timer? _refreshTimer;

  final RxBool hasLoaded = false.obs;

  void _scheduleNext() {
    _refreshTimer?.cancel();

    final duration = hasLoaded.value
        ? const Duration(seconds: 30)
        : const Duration(seconds: 5);

    _refreshTimer = Timer(duration, () async {
      await getMainScreenData();
      _scheduleNext();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getMainScreenData().then((_) => _scheduleNext());
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  Future<void> getMainScreenData() async {
    if (!hasLoaded.value) {
      isLoading.value = true;
    }
    final loaded = await Get.find<MainScreenService>().getMainScreenData(
      hasLoaded.value,
    );

    if (loaded != null) {
      if (!hasLoaded.value) {
        hasLoaded.value = loaded;
      }
    } else {
      Get.offAllNamed(AppRoutes.subscribe);
    }

    isLoading.value = false;
  }
}
