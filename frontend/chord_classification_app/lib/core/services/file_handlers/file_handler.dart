import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'audio_handler.dart';

abstract final class FileHandler {
  FileHandler._();
  static ImagePicker get _picker => ImagePicker();

  static Future<File?> getMusicFile() async {
    final file = await FilePicker.platform.pickFiles(allowCompression: false);
    if (file != null) {
      return AdvanceAudioHandler.convertToWav(File(file.files.single.path!));
    }
    return null;
  }

  static Future<File?> getVideoFile() async {
    final file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      return AdvanceAudioHandler.convertToWav(File(file.path));
    }
    return null;
  }
}
