import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/int_extensions.dart';
import '../../../../../core/services/file_handlers/audio_handler.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/controller_providers.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../../widgets/text/app_text.dart';
import '../../chord_prediction/providers/music_notifier_provider.dart';
import '../dependency_injection/audio_injection.dart';
import '../widgets/audio_list_player.dart';
import '../widgets/audio_name_dialog.dart';

class AudioCropperList extends ConsumerWidget {
  const AudioCropperList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioListFiles = ref.watch(cropFileListProvider);
    final audioList = audioListFiles.croppedFiles;
    final nameController = ref.read(textController("name"));
    if (audioList.isEmpty) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: 16.allPad,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(thickness: 1.ht),
          AppText("Total Seconds: ${audioListFiles.totalSeconds}"),
          ReorderableListView.builder(
              shrinkWrap: true,
              physics: Get.scrollPhysics,
              itemCount: audioList.length,
              itemBuilder: (context, index) => AudioListPlayer(
                    audioList[index],
                    key: Get.key(audioList[index]),
                    onTap: () => audioListFiles.removeMusic(index),
                  ),
              onReorder: audioListFiles.reOrder),
          Divider(),
          AppText("Note: Hold and drag to reorder",
              textAlign: TextAlign.center,
              fontSize: 8,
              textColor: AppColors.red),
          Divider(thickness: 1.ht),
          AppButton(
              onTap: () async {
                await showSetNameDialog(nameController);
                final file = await AdvanceAudioHandler.mergeMusic(
                    audioList, nameController.text);
                ref.read(musicFileProvider.notifier).state = file;
                Get.pop();
              },
              text: audioList.length == 1 ? "Classify" : "Merge and Classify")
        ],
      ),
    );
  }
}
