import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'audio_handler.dart';

final class FileHandler {
  FileHandler._();

  static Future<File?> getMusicFile() async {
    final file = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ['wav']);
    if (file != null) {
      return AdvanceAudioHandler.convertToWav(File(file.files.single.path!));
    }
    return null;
  }

  static Future<File?> getVideoFile() async {
    final file = await FilePicker.platform
        .pickFiles(allowCompression: true, type: FileType.video);
    if (file != null) {
      return AdvanceAudioHandler.convertToWav(File(file.files.single.path!));
    }
    return null;
  }
}
