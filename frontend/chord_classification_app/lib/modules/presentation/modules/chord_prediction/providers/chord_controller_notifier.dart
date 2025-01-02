import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/core.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/constants/chord_map.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../domain/entities/chord_prediction/chord_prediction.dart';

class ChordControllerNotifier extends ChangeNotifier {
  List<ChordPrediction> chordPredictions = [];
  String chordValue = '';
  PlayerController playerController = PlayerController();
  RangeController rangeController = RangeController(start: 0, end: 8);
  Color color = AppColors.primary;
  bool isPlaying = false;
  int currentIndex = 0;
  Timer? timer;

  ChordControllerNotifier(File file) {
    playerController.preparePlayer(path: file.path);
    playerController.setFinishMode(finishMode: FinishMode.pause);
    playerController.onCompletion.listen((_) {
      playerController.seekTo(0);
      isPlaying = false;
      currentIndex = 0;
    });
    playerController.onCurrentDurationChanged.listen((sec) {
      updateChord(sec);
    });
  }

  @override
  void dispose() {
    super.dispose();
    playerController.removeListener(() {});
    rangeController.removeListener(() {});
    playerController.dispose();
    rangeController.dispose();
    timer?.cancel();
  }

  updateChord(int currentDuration) {
    int start = currentDuration ~/ 1000;
    rangeController.start = start;
    rangeController.end = start + 8;
    for (int i = 0; i < chordPredictions.length; i++) {
      final prediction = chordPredictions[i];
      if (currentDuration >= prediction.start * 1000 &&
          currentDuration < prediction.end * 1000) {
        updateChordValue(
            '${prediction.chord} (${prediction.start}-${prediction.end}) sec');
        color = chordToColor[prediction.chord] ?? AppColors.titleColor;
        currentIndex = i;
        break;
      }
    }
    notifyListeners();
  }

  updatePredictions(List<ChordPrediction> predictions) {
    chordPredictions = [...predictions];
    color = chordToColor[predictions.first.chord] ?? AppColors.titleColor;
    notifyListeners();
  }

  updateChordValue(String chordValue) {
    this.chordValue = chordValue;
    notifyListeners();
  }

  updateFromGraph(int index) {
    currentIndex = index;
    playerController.seekTo(chordPredictions[index].start * 1000);
  }

  seekTo(int start) {
    currentIndex = chordPredictions.indexWhere((c) => c.start == start);
    playerController.seekTo(start * 1000);
    timer?.cancel();
    notifyListeners();
  }

  updateIsPlaying() {
    if (isPlaying) {
      playerController.pausePlayer();
      isPlaying = false;
    } else {
      playerController.startPlayer();
      isPlaying = true;
    }
    timer?.cancel();
    notifyListeners();
  }

  playTheChord(int start) async {
    seekTo(start);
    updateIsPlaying();
    final duration = chordPredictions[currentIndex].end -
        chordPredictions[currentIndex].start;
    timer = Timer.periodic((duration + 1).seconds, (_) {
      updateIsPlaying();
    });
  }
}
