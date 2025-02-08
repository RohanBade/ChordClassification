import '../../../domain/entities/local_chord_model/local_chord_prediction.dart';
import '../../../domain/repositories/saved_prediction/saved_prediction_repo.dart';
import '../../datasource/saved_prediction/saved_prediction_local_data_source.dart';

class SavedPredictionImpl implements SavedPredictionRepo {
  SavedPredictionImpl(this.savedLocalDataSrc);

  final SavedPredictionLocalDataSrc savedLocalDataSrc;

  @override
  Future<List<LocalChord>> fetchChords() async {
    return await savedLocalDataSrc.fetchChords();
  }
}
