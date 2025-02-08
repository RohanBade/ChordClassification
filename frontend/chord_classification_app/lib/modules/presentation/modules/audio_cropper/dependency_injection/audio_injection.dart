import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/audio_cropper_list.dart';
import '../providers/audio_cropper_notifier.dart';

final cropperNotifierProvider =
    ChangeNotifierProvider.autoDispose.family((ref, File file) {
  final notifier = AudioCropperNotifier(file,ref.read(cropFileListProvider));
  ref.onDispose(notifier.dispose);
  return notifier;
});

final croppedFileProvider = StateProvider.autoDispose<File?>((ref) => null);

final cropFileListProvider =
    ChangeNotifierProvider.autoDispose((ref) => AudioCropperListNotifier());
