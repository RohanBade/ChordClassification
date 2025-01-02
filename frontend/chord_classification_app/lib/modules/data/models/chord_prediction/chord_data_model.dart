import '../../../domain/entities/chord_prediction/chord_prediction.dart';

class ChordPredictionModel extends ChordPrediction {
 ChordPredictionModel({
    required super.start,
    required super.end,
    required super.chord,
  });

  factory ChordPredictionModel.fromJson(Map<String, dynamic> json) {
    return ChordPredictionModel(
        start: json['start'] as int,
        end: json['end'] as int,
        chord: json['chord'] as String);
  }
}