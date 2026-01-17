import 'package:get/get.dart';
import 'package:trade_pips_ai_flutter/core/services/storage_service.dart';
import 'package:trade_pips_ai_flutter/core/services/user_service.dart';
import 'package:trade_pips_ai_flutter/models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);

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

  Future<void> changeUserData({
    String? name,
    String? email,
    bool? enablePushNotifications,
    bool? enableNewsUpdates,
  }) async {
    final currentUser = user.value;
    final updatedUser = user.value?.copyWith(
      name: name,
      email: email,
      enableNewsUpdates: enableNewsUpdates,
      enablePushNotifications: enablePushNotifications,
    );

    user.value = updatedUser;

    final savedData = await Get.find<UserService>().saveUserData(
      name: name,
      email: email,
      enablePushNotifications: enablePushNotifications,
      enableNewsUpdates: enableNewsUpdates,
    );

    if (savedData) {
      saveUser(updatedUser!);
    } else {
      user.value = currentUser;
    }
  }

  Future<void> saveUser(UserModel toStoreUser) async {
    final storage = Get.find<StorageService>();
    await storage.saveUser(toStoreUser);
    user.value = toStoreUser;
  }

  Future<bool> refreshAccessToken() async {
    final accessToken = await Get.find<UserService>().refreshAccessToken(
      user.value!.refreshToken,
    );
    if (accessToken != null) {
      saveUser(user.value!.copyWith(accessToken: accessToken));
      return true;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    final storage = Get.find<StorageService>();

    await storage.clear();
    user.value = null;
  }
}
