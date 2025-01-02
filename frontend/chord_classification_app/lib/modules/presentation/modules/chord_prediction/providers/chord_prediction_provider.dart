import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';

final chordPredictionProvider = FutureProviderFamily((ref, File file) async{
  final predictedData =
      await ref.read(chordPredictionRepoProvider).getPredictionData(file);

  ref.read(chordPredictionNotifier).updatePredictions(predictedData);
  return predictedData;
});
