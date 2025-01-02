import 'dart:io';
import '../../entities/chord_prediction/chord_prediction.dart';

abstract class ChordPredictionRepo {
  Future<List<ChordPrediction>> getPredictionData(File file);
}