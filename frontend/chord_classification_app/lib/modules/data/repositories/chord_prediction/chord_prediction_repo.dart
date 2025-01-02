import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/services/get.dart';
import '../../../domain/entities/chord_prediction/chord_prediction.dart';
import '../../../domain/repositories/chord_prediction/chord_prediction_repo.dart';
import '../../datasource/chord_prediction/chord_prediction_remote_data_source.dart';

class ChordPredictionRepoImpl implements ChordPredictionRepo {
  ChordPredictionRepoImpl(this._chordPredictionRemoteDataSource);

  final ChordPredictionRemoteDataSource _chordPredictionRemoteDataSource;

  @override
  Future<List<ChordPrediction>> getPredictionData(File file) async {
    try {
      return await _chordPredictionRemoteDataSource.getPredictionData(file);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['detail'];
      Get.snackbar(errorMessage);
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
