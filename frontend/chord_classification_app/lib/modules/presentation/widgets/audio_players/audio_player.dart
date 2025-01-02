import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/configs/app_colors.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/services/file_handlers/file_handler.dart';
import '../../../../core/services/get.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../injection_container.dart';
import '../../modules/chord_prediction/providers/music_notifier_provider.dart';
import '../buttons/icon_buttons.dart';
import '../text/app_text.dart';

class AudioPlayer extends ConsumerWidget {
  const AudioPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chordNotifier = ref.watch(chordPredictionNotifier);
    final isPlaying = chordNotifier.isPlaying;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 5.ht,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppIcon(isPlaying ? AppIcons.pause : AppIcons.play,
                onTap: () => chordNotifier.updateIsPlaying(),
                color: Get.disabledColor),
            AudioFileWaveforms(
                playerController: chordNotifier.playerController,
                continuousWaveform: true,
                playerWaveStyle: PlayerWaveStyle(
                    fixedWaveColor: AppColors.primary.o5,
                    seekLineColor: chordNotifier.color.o4,
                    waveCap: StrokeCap.round,
                    spacing: 5.5.st,
                    seekLineThickness: 20.st,
                    liveWaveColor: AppColors.blue),
                size: Size(Get.width * 0.7, 50.ht)),
            AppIcon(AppIcons.reload, onTap: () async {
              final file = await FileHandler.getMusicFile();
              ref.read(musicFileProvider.notifier).state = file;
              chordNotifier.updatePredictions([]);
              chordNotifier.updateChordValue('');
            }, color: Get.disabledColor),
          ],
        ),
        AppText(chordNotifier.chordValue),
        5.verticalGap,
      ],
    );
  }
}
