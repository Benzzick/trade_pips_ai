import 'dart:async';

import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/presentation/tab/main_screen_service.dart';

class MainScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isLoading = false.obs;
  Timer? _refreshTimer;

  final RxBool hasLoaded = false.obs;

  @override
  void onReady() {
    super.onInit();
    getMainScreenData();
    _refreshTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      getMainScreenData();
    });
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

    if (!hasLoaded.value) {
      hasLoaded.value = loaded;
    }

    isLoading.value = false;
  }
}
