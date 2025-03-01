import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path_provider/path_provider.dart';
import '../get.dart';

abstract final class AdvanceAudioHandler {
  AdvanceAudioHandler._();

  static Future<Directory> get _directory async => await getTemporaryDirectory();

  static Future<File?> convertToWav(File file) async {
    final filePath = file.path;
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
    Get.snackbar("Unexpected Internal Error, Try Again");
    return null;
  }

  static Future<File?> convertVideoToWav(File file) async {
    final filePath = file.path;
    String outputPath = filePath.replaceAll(RegExp(r'\.\w+$'), '.wav');
    String command = '-i "$filePath" -map 0:a -acodec libmp3lame "$outputPath"';
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return File(outputPath);
    }
    Get.snackbar("Unexpected Internal Error, Try Again");
    return null;
  }

  static Future<File?> cropMusic(File file, int startTime, int endTime) async {
    final inputPath = file.path;
    final duration = ((endTime - startTime) / 1000 + 1).ceil();
    final dir = await _directory;
    final outputPath =
        "${dir.path}/${DateTime.now().millisecond}trimmedAudio.wav";

    String command =
        '-ss ${(startTime / 1000).floor()} -i "$inputPath" -t $duration -c copy "$outputPath"';
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return File(outputPath);
    }
    Get.snackbar("Unexpected Internal Error, Try Again");
    return null;
  }

  static Future<File?> mergeMusic(List<File> files) async {
    if (files.length == 1) {
      return files[0];
    }
    String command = '';
    String fileCommand = '';

    for (int i = 0; i < files.length; i++) {
      final file = files[i];
      command += '-i ${file.path} ';
      fileCommand += "[$i:a]";
    }
    final dir = await _directory;
    final outputPath =
        "${dir.path}/${DateTime.now().millisecond}mergedAudio.wav";
    command +=
        ' -filter_complex "${fileCommand}concat=n=${files.length}:v=0:a=1" $outputPath';
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return File(outputPath);
    }
    Get.snackbar("Unexpected Internal Error, Try Again");
    return null;
  }
}
