import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../widgets/buttons/icon_buttons.dart';
import '../../../widgets/listtile/app_list_tile.dart';

class AudioListPlayer extends StatefulWidget {
  const AudioListPlayer(this.file, {super.key, required this.onTap});
  final File file;
  final VoidCallback onTap;

  @override
  State<AudioListPlayer> createState() => _AudioListPlayerState();
}

class _AudioListPlayerState extends State<AudioListPlayer> {
  bool isPlaying = false;
  final playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  initPlayer() async {
    await playerController.preparePlayer(path: widget.file.path);
    playerController.setFinishMode(finishMode: FinishMode.pause);
    playerController.onCompletion.listen((_) {
      playerController.seekTo(0);
      isPlaying = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
    widget.file.delete();
  }

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: AudioFileWaveforms(
          playerController: playerController,
          waveformType: WaveformType.long,
          continuousWaveform: true,
          padding: EdgeInsets.symmetric(vertical: 8.rt),
          playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: AppColors.primary.o5,
              waveCap: StrokeCap.round,
              spacing: 3.st,
              seekLineColor: AppColors.red,
              waveThickness: 2.st,
              liveWaveColor: AppColors.blue),
          size: Size(310.st, 25.ht)),
      leading: AppIcon(isPlaying ? AppIcons.pause : AppIcons.play,
          onTap: () => setState(() {
                if (isPlaying) {
                  playerController.pausePlayer();
                } else {
                  playerController.startPlayer();
                }
                isPlaying = !isPlaying;
              }),
          color: Get.disabledColor),
      trailing: AppIcon(
        AppIcons.delete,
        color: AppColors.red,
        onTap: widget.onTap,
      ),
    );
  }
}
