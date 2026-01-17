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

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      time: DateTime.tryParse(json['published_at'] ?? '') ?? DateTime.now(),
      currency: json['pair'] as String,
      title: json['title'] as String,
      description: json['sentiment'] as String,
      impact: _impactFromString(json['impact'] as String),
    );
  }

  static NewsImpact _impactFromString(String impact) {
    switch (impact.toLowerCase()) {
      case 'high':
        return NewsImpact.high;
      case 'medium':
        return NewsImpact.medium;
      case 'low':
      default:
        return NewsImpact.low;
    }
  }
}
