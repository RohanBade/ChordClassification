import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/configs/app_colors.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/services/file_handlers/file_handler.dart';
import '../../../../core/services/get.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../injection_container.dart';
import '../../modules/audio_cropper/views/audio_cropper.dart';
import '../../modules/chord_prediction/providers/music_notifier_provider.dart';
import '../buttons/icon_buttons.dart';
import '../text/app_text.dart';

class AudioPlayer extends ConsumerWidget {
  const AudioPlayer(this.file, {super.key, this.isCache = false});

  final File file;
  final bool isCache;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chordNotifier = ref.watch(chordPredictionNotifier(file));
    final isPlaying = chordNotifier.isPlaying;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 2.ht,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppIcon(isPlaying ? AppIcons.pause : AppIcons.play,
                onTap: () => chordNotifier.updateIsPlaying(),
                color: Get.disabledColor),
            AudioFileWaveforms(
                playerController: chordNotifier.playerController,
                waveformData: chordNotifier.waveformAmplitudes,
                playerWaveStyle: PlayerWaveStyle(
                    fixedWaveColor: AppColors.primary.o5,
                    seekLineColor: chordNotifier.color.o4,
                    waveCap: StrokeCap.round,
                    spacing: 5.st,
                    seekLineThickness: 15.st,
                    liveWaveColor: AppColors.blue),
                size: Size(Get.width * 0.65, 35.ht)),
            if (!isCache)
              AppIcon(AppIcons.reload, onTap: () async {
                chordNotifier.updatePlay(false);
                final file = await FileHandler.getMusicFile();
                if (file != null) {
                  ref.read(trimMusicFileProvider.notifier).state = file;
                  Get.to(AudioCropper());
                }
              }, color: Get.disabledColor),
          ],
        ),
        AppText(chordNotifier.chordValue, style: Get.bodySmall),
        5.verticalGap,
      ],
    );
  }
}
