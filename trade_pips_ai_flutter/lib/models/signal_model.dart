class SignalModel {
  final SignalDirection direction;
  final String pair;
  final String strategy;
  final DateTime timeGotSignal;
  final int targetPips;
  final String timeFrame;
  final int probability;
  final double entryPrice;
  final List<double> takeProfitPrice;
  final List<double> stopLossPrice;
  final double contractSize;
  final double tickSize;
  final double tickValue;
  final double minLot;
  final double lotStep;
  final double maxLot;
  final bool isIndex;

  const SignalModel({
    required this.direction,
    required this.pair,
    required this.strategy,
    required this.timeGotSignal,
    required this.targetPips,
    required this.timeFrame,
    required this.probability,
    required this.entryPrice,
    required this.takeProfitPrice,
    required this.stopLossPrice,
    required this.contractSize,
    required this.tickSize,
    required this.tickValue,
    required this.minLot,
    required this.lotStep,
    required this.maxLot,
    required this.isIndex,
  });

  factory SignalModel.fromJson(Map<String, dynamic> json) {
    return SignalModel(
      direction: json['direction'] == 'BUY'
          ? SignalDirection.buy
          : SignalDirection.sell,
      pair: json['pair'],
      strategy: json['strategy'],
      timeGotSignal: DateTime.parse(json['created_at']),
      targetPips: json['target_pips'],
      timeFrame: json['timeframe'],
      probability: json['probability'],
      entryPrice: double.parse(json['entry_price'].toString()),
      takeProfitPrice: (json['take_profit_price'] as List)
          .map((e) => double.parse(e.toString()))
          .toList(),
      stopLossPrice: (json['stop_loss_price'] as List)
          .map((e) => double.parse(e.toString()))
          .toList(),
      contractSize: (json['contract_size'] as num).toDouble(),
      tickSize: (json['tick_size'] as num).toDouble(),
      tickValue: (json['tick_value'] as num).toDouble(),
      minLot: (json['min_lot'] as num).toDouble(),
      lotStep: (json['lot_step'] as num).toDouble(),
      maxLot: (json['max_lot'] as num).toDouble(),
      isIndex: json['is_index'] ?? false,
    );
  }
}

enum SignalDirection { buy, sell }

class NotificationModel {
  final SignalDirection direction;
  final String pair;
  final String strategy;
  final DateTime timeGotSignal;
  final int targetPips;
  final String timeFrame;
  final int probability;
  final double entryPrice;
  final double takeProfitPrice;
  final double stopLossPrice;

  const NotificationModel({
    required this.direction,
    required this.pair,
    required this.strategy,
    required this.timeGotSignal,
    required this.targetPips,
    required this.timeFrame,
    required this.probability,
    required this.entryPrice,
    required this.takeProfitPrice,
    required this.stopLossPrice,
  });
}
