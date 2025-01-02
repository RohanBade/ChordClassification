import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:file_picker/file_picker.dart';

import '../get.dart';

final class FileHandler {
  FileHandler._();

  static Future<File?> getMusicFile() async {
    final file = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ['wav']);
    if (file != null) {
      final filePath = file.files.single.path!;
      // return File(filePath);
      if (filePath.contains('.wav')) {
        return File(filePath);
      }
      String outputPath = filePath.replaceAll(RegExp(r'\.\w+$'), '.wav');
      String command = '-i "$filePath" "$outputPath"';
      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        return File(outputPath);
      }
      Get.snackbar("Unexpected Error Occurs");
      return null;
    }
    return null;
  }
}
