import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/file_handlers/audio_handler.dart';
import '../../../../../core/services/get.dart';
import 'audio_cropper_list.dart';

class AudioCropperNotifier extends ChangeNotifier {
  final File file;
  final AudioCropperListNotifier audioListNotifier;

  int currentTime = 0;
  int endTime = 0;
  int startTime = 0;

  int maxSecond = 50 * 1000;
  int minSecond = 10 * 1000;

  PlayerController playerController = PlayerController();
  bool isPlaying = false;

  double width = 320;

  double _startPosition = 0;
  double _endPosition = 0;

  double widthPerDuration = 0;
  double durationPerWidth = 0;

  double trimWidth = 320;

  double _maximumWidth = 30;
  double _minimumWidth = 30;

  final double _originalPos = Get.width - 318.rt;

  double trimmerPosition = Get.width - 318.rt;

  double get bottomPanner => trimWidth * 0.5 - 8;

  int get timeDifference => ((endTime - currentTime) / 1000).ceil();

  final GlobalKey widgetKey = GlobalKey();

  List<File> files = [];

  AudioCropperNotifier(this.file, this.audioListNotifier) {
    preparePlayer();
  }

  @override
  void dispose() {
    super.dispose();
    playerController.removeListener(() {});
    playerController.dispose();
  }

  preparePlayer() async {
    await playerController.preparePlayer(path: file.path);
    playerController.setFinishMode(finishMode: FinishMode.pause);
    playerController.onCompletion.listen((_) {
      playerController.seekTo(0);
      isPlaying = false;
    });
    playerController.onCurrentDurationChanged.listen((sec) {
      currentTime = sec;
      if (currentTime > endTime) {
        playerController.seekTo(startTime);
        updateIsPlaying();
      }
      notifyListeners();
    });
    _getWidth();
    _getTimeStuff();
    _updateMinMax();
    _widthOfTrimmer();
    updateTime();
    notifyListeners();
  }

  _updateMinMax() {
    if (file.path.contains('trimmedAudio.wav')) {
      minSecond = 1 * 1000;
      maxSecond = 40 * 1000;
    }
  }

  _getTimeStuff() {
    widthPerDuration = width / duration;
    durationPerWidth = 1 / widthPerDuration;
  }

  _widthOfTrimmer() {
    _minimumWidth = widthPerDuration * minSecond;
    if (duration <= 40 * 1000) {
      trimWidth = width - 33.st;
      _maximumWidth = trimWidth;
      notifyListeners();
      return;
    }
    trimWidth = widthPerDuration * maxSecond;
    _maximumWidth = trimWidth.floorToDouble();
  }

  updateTime() {
    startTime = ((-_originalPos + trimmerPosition) * durationPerWidth).floor();
    endTime = startTime + (trimWidth * durationPerWidth).ceil();
    if (endTime > duration) {
      endTime = duration;
    }
    playerController.seekTo(startTime);
    notifyListeners();
  }

  int get duration => playerController.maxDuration;

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

  void onHorizontalDragUpdateRight(DragUpdateDetails details) {
    trimWidth += details.primaryDelta ?? 0; // Reduce width as user swipes

    if (trimWidth < _minimumWidth) trimWidth = _minimumWidth;

    if (trimWidth > _maximumWidth) trimWidth = _maximumWidth;
    updateTime();
    notifyListeners();
  }

  void onHorizontalDragUpdateLeft(DragUpdateDetails details) {
    trimWidth -= details.primaryDelta ?? 0;
    if (trimWidth < _minimumWidth) {
      trimWidth = _minimumWidth;
    }

    if (trimWidth > _maximumWidth) {
      trimWidth = _maximumWidth;
    }
    onHorizontalDragUpdateButtom(details);
  }

  void onHorizontalDragUpdateButtom(DragUpdateDetails details) {
    _getWidth();
    trimmerPosition += details.primaryDelta ?? 0;

    if (trimmerPosition < _startPosition) {
      trimmerPosition = _startPosition;
    }
    if (trimmerPosition + trimWidth > _endPosition) {
      final offset = trimmerPosition + trimWidth - _endPosition;
      trimmerPosition -= offset;
    }
    updateTime();
  }

  _getWidth() {
    final renderBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      width = renderBox.size.width;
      Offset position = renderBox.localToGlobal(Offset.zero); // Get position
      _startPosition = position.dx; // Left position (starting point)
      _endPosition = _startPosition + renderBox.size.width - 10.rt;
    }
  }

  Future<File?> trim() async {
    final trimFile =
        await AdvanceAudioHandler.cropMusic(file, startTime, endTime);
    if (trimFile != null) {
      updateIsPlaying();
      return trimFile;
    }
    return null;
  }

  Future<bool> confirm() async {
    final file = await trim();
    if (file != null) {
      return audioListNotifier.addMusic(file, (endTime - startTime) ~/ 1000);
    }
    return false;
  }
}
