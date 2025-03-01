import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import '../../../../abstractservices/storage_services.dart';
import '../../../../core/utils/storage_key_constants.dart';
import '../../../domain/entities/local_chord_model/local_chord_prediction.dart';
import '../../models/local_chord/local_chord_model.dart';

abstract class SavedPredictionLocalDataSrc {
  Future<List<LocalChord>> fetchChords();
}

class SavedPredictionLocalDataSrcImpl implements SavedPredictionLocalDataSrc {
  SavedPredictionLocalDataSrcImpl(this.storageServices);

  final StorageServices storageServices;

  @override
  Future<List<LocalChord>> fetchChords() async {
    List<LocalChord> chords = [];
    final storedData = await storageServices.get(StorageKeys.storedChords);
    if (storedData == null) {
      return chords;
    }
    final tempDir = await getTemporaryDirectory();
    for (var i in jsonDecode(storedData)) {
      LocalChord chord = LocalChordModel.fromJson(i);
      Uint8List fileBytes =
          Uint8List.fromList(List<int>.from(jsonDecode(chord.fileBytes)));
      final filePath = '${tempDir.path}/${chord.fileName}';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);
      chord = chord.copyWith(file: file);
      chords.add(chord);
    }
    return chords;
  }
}