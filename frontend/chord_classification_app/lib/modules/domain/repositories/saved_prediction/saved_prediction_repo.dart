import '../../entities/local_chord_model/local_chord_prediction.dart';

abstract class SavedPredictionRepo {
  Future<List<LocalChord>> fetchChords();
}
