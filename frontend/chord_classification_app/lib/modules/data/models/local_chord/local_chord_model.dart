import 'dart:convert';

import '../../../domain/entities/local_chord_model/local_chord_prediction.dart';
import '../chord_prediction/chord_data_model.dart';

class LocalChordModel extends LocalChord {
  LocalChordModel(
      {required super.fileName,
      required super.fileBytes,
      required super.predictions,
      required super.amplitudes,
      super.file});

  Map<String, dynamic> toJson() {
    final predictionJson =
        predictions.map((e) => (e as ChordPredictionModel).toJson()).toList();
    return {
      'fileName': fileName,
      'predictions': predictionJson,
      'fileBytes': fileBytes,
      'amplitudes': jsonEncode(amplitudes)
    };
  }

  factory LocalChordModel.fromJson(Map<String, dynamic> json) {
    final predictions = (json['predictions'] as List<dynamic>)
        .map((e) => ChordPredictionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return LocalChordModel(
        fileName: json['fileName'],
        fileBytes: json['fileBytes'],
        amplitudes: List<double>.from(jsonDecode(json['amplitudes'])),
        predictions: predictions);
  }
}
