class TodayStatsModel {
  final String numberPercent;
  final String title;
  const TodayStatsModel({required this.numberPercent, required this.title});

  factory TodayStatsModel.fromJson(Map<String, dynamic> json) {
    return TodayStatsModel(
      numberPercent: json['numberPercent'] as String,
      title: json['title'] as String,
    );
  }
}
