import 'dart:io';
import 'package:audio_analyzer/audio_analyzer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/list_extension.dart';
import '../../../../injection_container.dart';

final chordPredictionProvider = FutureProviderFamily((ref, File file) async {
  final predictedData =
      await ref.read(chordPredictionRepoProvider).getPredictionData(file);
  final amplitudes = await AudioAnalyzer().getAmplitudes(file.path);
  ref.read(chordPredictionNotifier(file)).updatePredictions(predictedData);
  ref.read(chordPredictionNotifier(file)).updateAmplitude(amplitudes.normalize);
  return predictedData;
});
