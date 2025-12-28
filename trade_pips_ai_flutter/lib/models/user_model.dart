class UserModel {
  final String name;
  final String email;
  final bool enablePushNotifications;
  final bool enableNewsUpdates;
  final DateTime subscriptionEndDate;

  const UserModel({
    required this.name,
    required this.email,
    required this.enablePushNotifications,
    required this.enableNewsUpdates,
    required this.subscriptionEndDate,
  });

  // 🔁 copyWith
  UserModel copyWith({
    String? name,
    String? email,
    bool? enablePushNotifications,
    bool? enableNewsUpdates,
    DateTime? subscriptionEndDate,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      enableNewsUpdates: enableNewsUpdates ?? this.enableNewsUpdates,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
    );
  }

  // 📤 toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'enablePushNotifications': enablePushNotifications,
      'enableNewsUpdates': enableNewsUpdates,
      'subscriptionDate': subscriptionEndDate,
    };
  }

  // 📥 fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      enablePushNotifications: json['enablePushNotifications'] ?? false,
      enableNewsUpdates: json['enableNewsUpdates'] ?? false,
      subscriptionEndDate: json['subscriptionDate'] ?? DateTime.now(),
    );
  }
}
