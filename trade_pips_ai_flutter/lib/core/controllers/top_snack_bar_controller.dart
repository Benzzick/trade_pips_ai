import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSnack {
  final String id;
  final String message;
  final Color backgroundColor;
  final IconData icon;

  TopSnack({
    required this.id,
    required this.message,
    required this.backgroundColor,
    required this.icon,
  });
}

class TopSnackBarController extends GetxController {
  final RxList<TopSnack> snacks = <TopSnack>[].obs;

  void show({
    required String message,
    required bool success,
  }) {
    final snack = TopSnack(
      id: UniqueKey().toString(),
      message: message,
      backgroundColor: success
          ? const Color.fromRGBO(30, 255, 0, 0.35)
          : const Color.fromRGBO(226, 20, 20, 0.35),
      icon: success ? Icons.check_circle : Icons.error,
    );

    if (snacks.length >= 2) {
      snacks.removeAt(0);
    }

    snacks.add(snack);

    Future.delayed(const Duration(seconds: 4), () {
      snacks.removeWhere((s) => s.id == snack.id);
    });
  }
}
