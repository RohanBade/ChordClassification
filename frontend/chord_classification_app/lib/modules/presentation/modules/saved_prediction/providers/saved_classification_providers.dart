import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../abstractservices/storage_services.dart';
import '../../../../../core/extensions/file.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/storage_key_constants.dart';
import '../../../../data/models/local_chord/local_chord_model.dart';
import '../../../../domain/entities/chord_prediction/chord_prediction.dart';
import '../../../../domain/entities/local_chord_model/local_chord_prediction.dart';
import '../../../../injection_container.dart';

class SavedClassification extends ChangeNotifier {
  SavedClassification(this.box);
  final StorageServices box;

  List<LocalChord> chords = [];
  List<Map<String, dynamic>> chordJson = [];

  void initRef(Ref ref, List<LocalChord> chords) {
    this.chords = chords;
    for (var i in chords) {
      final chord = LocalChordModel(
          fileName: i.fileName,
          fileBytes: jsonEncode(i.fileBytes),
          amplitudes: i.amplitudes,
          file: i.file,
          predictions: i.predictions);
      final chordNotifier = ref.read(chordPredictionNotifier(chord.file!));
      chordNotifier.updatePredictions(chord.predictions);
      chordNotifier.updateAmplitude(chord.amplitudes);
      chordJson.add(chord.toJson());
    }
    notifyListeners();
  }

  void storeChord(File file, List<ChordPrediction> predictions,
      List<double> amplitudes) async {
    final isFounded = chords.indexWhere((e) => e.file == file) != -1;
    if (isFounded) {
      Get.snackbar("Already Saved");
      return;
    }
    final fileBytes = await file.readAsBytes();
    final chord = LocalChordModel(
        fileName: file.fileName,
        fileBytes: jsonEncode(fileBytes),
        amplitudes: amplitudes,
        file: file,
        predictions: predictions);
    chords.add(chord);
    chordJson.add(chord.toJson());
    box.set(StorageKeys.storedChords, jsonEncode(chordJson));
    Get.banner("Saved");
    notifyListeners();
  }

  void deleteChord(int index) {
    chords.removeAt(index);
    chordJson.removeAt(index);
    notifyListeners();
    box.set(StorageKeys.storedChords, jsonEncode(chordJson));
  }

  void reOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final chord = chords.removeAt(oldIndex);
    chords.insert(newIndex, chord);
    final cJson = chordJson.removeAt(oldIndex);
    chordJson.insert(newIndex, cJson);
    notifyListeners();
    box.set(StorageKeys.storedChords, jsonEncode(chordJson));
  }
}
