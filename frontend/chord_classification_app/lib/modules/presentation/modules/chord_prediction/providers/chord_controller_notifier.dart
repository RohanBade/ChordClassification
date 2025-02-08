import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_core/core.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/constants/chord_map.dart';
import '../../../../domain/entities/chord_prediction/chord_prediction.dart';
import '../../../../injection_container.dart';
import '../view/amplitude_graph_view.dart';

class ChordControllerNotifier extends ChangeNotifier {
  List<ChordPrediction> chordPredictions = [];
  List<AmplitudeGraphData> amplitudesData = [];

  String chordValue = '';
  PlayerController playerController = PlayerController();
  RangeController rangeController = RangeController(start: 0, end: 6);
  RangeController amplitudeController = RangeController(start: 0, end: 1.5);
  Color color = AppColors.primary;
  bool isPlaying = false;
  int currentIndex = 0;
  double currentTime = 0;

  double speed = 1.0;

  int? stopTime;

  final Ref ref;
  final File file;

  ChordControllerNotifier(this.file, this.ref) {
    playerController.preparePlayer(path: file.path);
    playerController.setFinishMode(finishMode: FinishMode.pause);
    playerController.onCompletion.listen((_) {
      playerController.seekTo(0);
      isPlaying = false;
      currentIndex = 0;
    });
    playerController.setRate(speed);
    playerController.onCurrentDurationChanged.listen((sec) {
      if (amplitudesData.isEmpty) {
        updateAmplitudeData();
      }
      updateChord(sec);
    });
  }

  @override
  void dispose() {
    super.dispose();
    playerController.removeListener(() {});
    playerController.dispose();
    rangeController.dispose();
    amplitudeController.dispose();
  }

  List<double> amplitudes = [];
  double get duration => playerController.maxDuration / 1000;

  double get timePerSample => duration / amplitudes.length;

  ChordPrediction get currentChord => chordPredictions[currentIndex];

  updateChord(int currentDuration) {
    currentTime = currentDuration / 1000;
    rangeController.start = currentTime;
    rangeController.end = currentTime + 6;
    amplitudeController.start = currentTime;
    amplitudeController.end =
        currentTime + (currentChord.end - currentChord.start);
    if (stopTime != null && currentDuration >= stopTime! * 1000) {
      updateIsPlaying();
      stopTime = null;
    }
    final playingIndex = chordPredictions.indexWhere((c) =>
        currentDuration >= c.start * 1000 && currentDuration < c.end * 1000);
    currentIndex = playingIndex;
    final prediction = chordPredictions[currentIndex];
    updateChordValue(
        '${prediction.chord} (${prediction.start}-${prediction.end}) sec');
    color = chordToColor[prediction.chord] ?? AppColors.titleColor;
    notifyListeners();
  }

  updateSpeed(double speed) {
    this.speed = speed;
    playerController.setRate(speed);
    notifyListeners();
  }

  updatePredictions(List<ChordPrediction> predictions) {
    chordPredictions = [...predictions];
    color = chordToColor[predictions.first.chord] ?? AppColors.titleColor;
    notifyListeners();
  }

  updateAmplitude(List<double> amplitudes) {
    this.amplitudes = amplitudes;
    updateAmplitudeData();
    notifyListeners();
  }

  updateAmplitudeData() {
    for (var i = 0; i < amplitudes.length; i++) {
      amplitudesData.add(AmplitudeGraphData(
          amplitude: amplitudes[i], duration: i * timePerSample));
    }
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
    playerController.seekTo(start * 1000);
    notifyListeners();
  }

  panGraph(String startGraph) {
    double start = double.parse(startGraph);
    if (isPlaying) {
      return;
    }
    playerController.seekTo((start * 1000).toInt());
  }

  updateIsPlaying() {
    if (isPlaying) {
      playerController.pausePlayer();
      isPlaying = false;
    } else {
      playerController.startPlayer();
      isPlaying = true;
    }
    notifyListeners();
  }

  playTheChord(int start) async {
    currentIndex = chordPredictions.indexWhere((c) => c.start == start);
    stopTime = chordPredictions[currentIndex].end;
    seekTo(start);
    updateIsPlaying();
  }

  saveOutputData() {
    ref
        .read(savedClassificationProvider)
        .storeChord(file, chordPredictions, amplitudes);
  }
}
