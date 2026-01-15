import 'package:get_storage/get_storage.dart';
import '../../models/user_model.dart';

class StorageService {
  final _box = GetStorage();

  static const _userKey = 'user';

  // Save
  Future<void> saveUser(UserModel user) async {
    await _box.write(_userKey, user.toJson());
  }

  // Read
  UserModel? getUser() {
    final data = _box.read(_userKey);
    if (data == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(data));
  }

  // Clear
  Future<void> clear() async {
    await _box.erase();
  }
}
