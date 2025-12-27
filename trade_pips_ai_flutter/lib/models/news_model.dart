enum NewsImpact {
  low,
  medium,
  high,
}

class NewsModel {
  final DateTime time;
  final String currency;
  final String title;
  final String description;
  final NewsImpact impact;

  NewsModel({
    required this.time,
    required this.currency,
    required this.title,
    required this.description,
    required this.impact,
  });
}
