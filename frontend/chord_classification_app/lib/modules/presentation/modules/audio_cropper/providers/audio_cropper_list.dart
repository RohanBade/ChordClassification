import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../../core/services/get.dart';

class AudioCropperListNotifier extends ChangeNotifier {
  List<File> croppedFiles = [];
  int totalSeconds = 0;
  List<int> fileDurations = [];

  @override
  void dispose() {
    for (var i in croppedFiles) {
      i.delete();
    }
    super.dispose();
  }

  bool addMusic(File file, int second) {
    if (totalSeconds + second > 40) {
      Get.snackbar("Audio Length Limit, 40 sec");
      file.delete();
      return false;
    }
    fileDurations.add(second);
    totalSeconds += second;
    croppedFiles.add(file);
    notifyListeners();
    return true;
  }

  void removeMusic(int index) {
    totalSeconds -= fileDurations[index];
    croppedFiles.removeAt(index);
    fileDurations.removeAt(index);
    notifyListeners();
  }

  void reOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final music = croppedFiles.removeAt(oldIndex);
    croppedFiles.insert(newIndex, music);
    final duration = fileDurations.removeAt(oldIndex);
    fileDurations.insert(newIndex, duration);
    notifyListeners();
  }
}
