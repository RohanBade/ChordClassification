import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../widgets/buttons/icon_buttons.dart';
import '../../../widgets/text/app_text.dart';
import '../dependency_injection/audio_injection.dart';

class AudioCropperView extends ConsumerWidget {
  const AudioCropperView(this.file,
      {super.key, this.color = AppColors.reddisBrown});

  final File file;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cropperNotifier = ref.watch(cropperNotifierProvider(file));
    final isPlaying = cropperNotifier.isPlaying;
    return Column(
      key: Get.key(file),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox.shrink(),
          AppText("Start ${(cropperNotifier.startTime).timeFormat}",
              fontSize: 10),
          SizedBox.shrink(),
          AppText(
              ("${cropperNotifier.currentTime.timeFormat} (${cropperNotifier.timeDifference})"),
              fontSize: 10),
          SizedBox.shrink(),
          AppText("End ${(cropperNotifier.endTime).timeFormat}", fontSize: 10),
        ]),
        4.verticalGap,
        Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppIcon(isPlaying ? AppIcons.pause : AppIcons.play,
                    onTap: () => cropperNotifier.updateIsPlaying(),
                    color: Get.disabledColor),
                AudioFileWaveforms(
                    key: cropperNotifier.widgetKey,
                    playerController: cropperNotifier.playerController,
                    waveformType: WaveformType.fitWidth,
                    continuousWaveform: true,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5.st, color: color),
                        borderRadius: BorderRadius.circular(10).rt),
                    padding: EdgeInsets.symmetric(vertical: 8.rt),
                    playerWaveStyle: PlayerWaveStyle(
                        fixedWaveColor: AppColors.primary.o5,
                        waveCap: StrokeCap.round,
                        spacing: 3.st,
                        waveThickness: 2.st,
                        liveWaveColor: color),
                    size: Size(310.st, 25.ht)),
              ],
            ),
            Positioned(
              left: cropperNotifier.trimmerPosition,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                      width: cropperNotifier.trimWidth.wt,
                      height: 39.ht,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5.st, color: color),
                          borderRadius: BorderRadius.circular(10).rt)),
                  Positioned(
                      top: 12.ht,
                      left: -8.wt,
                      child: GestureDetector(
                          onHorizontalDragUpdate:
                              cropperNotifier.onHorizontalDragUpdateLeft,
                          child: CircleAvatar(
                              radius: 8.rt, backgroundColor: color))),
                  Positioned(
                      top: 12.ht,
                      right: -8.rt,
                      child: GestureDetector(
                          onHorizontalDragUpdate:
                              cropperNotifier.onHorizontalDragUpdateRight,
                          child: CircleAvatar(
                              radius: 8.rt, backgroundColor: color))),
                  Positioned(
                      top: 38.ht - 8.rt,
                      left: (cropperNotifier.trimWidth * 0.5 - 8).wt,
                      child: GestureDetector(
                          onHorizontalDragUpdate:
                              cropperNotifier.onHorizontalDragUpdateButtom,
                          child: CircleAvatar(
                              radius: 8.rt, backgroundColor: color)))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
