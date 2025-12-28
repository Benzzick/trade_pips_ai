class SubscriptionModel {
  final String subName;
  final double price;
  final String duration;
  final List<String> thingsToGet;
  const SubscriptionModel({
    required this.subName,
    required this.price,
    required this.duration,
    required this.thingsToGet,
  });
}
