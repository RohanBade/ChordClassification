import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/file_handlers/file_handler.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/assets_path.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../audio_cropper/views/audio_cropper.dart';
import '../providers/music_notifier_provider.dart';

class MusicSelectionView extends ConsumerWidget {
  const MusicSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: 10.allPad,
      child: Column(
        spacing: 20.ht,
        children: [
          Image.asset(Assets.images.loadingImage),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: 120.wt,
                  child: AppButton(
                      onTap: () async {
                        final file = await FileHandler.getMusicFile();
                        if (file != null) {
                          ref.read(trimMusicFileProvider.notifier).state = file;
                          Get.to(AudioCropper());
                        }
                      },
                      text: "Pick Music")),
              SizedBox(
                  width: 120.wt,
                  child: AppButton(
                      onTap: () async {
                        final file = await FileHandler.getVideoFile();
                        if (file != null) {
                          ref.read(trimMusicFileProvider.notifier).state = file;
                          Get.to(AudioCropper());
                        }
                      },
                      text: "Pick Video"))
            ],
          ),
        ],
      ),
    );
  }
}
