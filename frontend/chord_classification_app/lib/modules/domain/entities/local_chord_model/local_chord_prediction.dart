import 'dart:io';

import 'package:flutter/foundation.dart';

import '../chord_prediction/chord_prediction.dart';

class LocalChord {
  final String fileName;
  final String fileBytes;
  final List<ChordPrediction> predictions;
  final List<double> amplitudes;
  final File? file;

  LocalChord(
      {required this.fileName,
      required this.fileBytes,
      required this.predictions,
      required this.amplitudes,
      this.file});

  LocalChord copyWith({
    String? fileName,
    String? fileBytes,
    List<ChordPrediction>? predictions,
    List<double>? amplitudes,
    File? file,
  }) {
    return LocalChord(
      fileName: fileName ?? this.fileName,
      fileBytes: fileBytes ?? this.fileBytes,
      predictions: predictions ?? this.predictions,
      amplitudes: amplitudes??this.amplitudes,
      file: file ?? this.file,
    );
  }


  @override
  bool operator ==(covariant LocalChord other) {
    if (identical(this, other)) return true;
  
    return 
      other.fileName == fileName &&
      other.fileBytes == fileBytes &&
      listEquals(other.predictions, predictions) &&
      listEquals(other.amplitudes, amplitudes) &&
      other.file == file;
  }

  @override
  int get hashCode {
    return fileName.hashCode ^
      fileBytes.hashCode ^
      predictions.hashCode ^
      amplitudes.hashCode ^
      file.hashCode;
  }
}
