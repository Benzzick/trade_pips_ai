import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel> user = UserModel(
    name: "Jahbuikem Nwazue",
    email: "email@email.com",
    enablePushNotifications: false,
    enableNewsUpdates: false,
  ).obs;

  String getNameAbbreviation(String name) {
    final trimmed = name.trim();

    if (trimmed.contains(' ')) {
      final parts = trimmed.split(RegExp(r'\s+'));
      return (parts[0][0] + parts[1][0]).toUpperCase();
    } else {
      return trimmed.length >= 2
          ? trimmed.substring(0, 2).toUpperCase()
          : trimmed.toUpperCase();
    }
  }

  void changeUserData({
    String? name,
    String? email,
    bool? enablePushNotifications,
    bool? enableNewsUpdates,
  }) {
    final updatedUser = user.value.copyWith(
      name: name,
      email: email,
      enableNewsUpdates: enableNewsUpdates,
      enablePushNotifications: enablePushNotifications,
    );

    user.value = updatedUser;
  }

  void logOut() {}
}
