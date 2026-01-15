class UserModel {
  final String name;
  final String email;
  final bool enablePushNotifications;
  final bool enableNewsUpdates;
  final String accessToken;
  final String refreshToken;

  const UserModel({
    required this.name,
    required this.email,
    required this.enablePushNotifications,
    required this.enableNewsUpdates,
    required this.accessToken,
    required this.refreshToken,
  });

  // 🔁 copyWith
  UserModel copyWith({
    String? name,
    String? email,
    bool? enablePushNotifications,
    bool? enableNewsUpdates,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      enableNewsUpdates: enableNewsUpdates ?? this.enableNewsUpdates,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  // 📤 toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'enablePushNotifications': enablePushNotifications,
      'enableNewsUpdates': enableNewsUpdates,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  // 📥 fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      enablePushNotifications: json['push_notifications'] ?? false,
      enableNewsUpdates: json['news_updates'] ?? false,
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}
