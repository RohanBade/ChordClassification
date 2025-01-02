import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/services/api_services/api_service.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../../domain/entities/chord_prediction/chord_prediction.dart';
import '../../models/chord_prediction/chord_data_model.dart';

abstract class ChordPredictionRemoteDataSource {
  Future<List<ChordPrediction>> getPredictionData(File file);
}

class ChordPredictionRemoteDataSourceImpl
    implements ChordPredictionRemoteDataSource {
  ChordPredictionRemoteDataSourceImpl(this._apiManager);

  final ApiManager _apiManager;
  @override
  Future<List<ChordPrediction>> getPredictionData(File file) async {
    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last)
    });
    final response =
        await _apiManager.fileUpload(ApiEndpoints.upload, data: data);

    final chordJsonList = response.data['predictions'] as List<dynamic>;
    
    return chordJsonList
        .map((e) => ChordPredictionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
