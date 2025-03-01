import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../../widgets/text/app_text.dart';
import '../../chord_prediction/providers/music_notifier_provider.dart';
import '../dependency_injection/audio_injection.dart';
import '../widgets/audio_trimmer_widget.dart';
import '../widgets/confirm_button.dart';
import '../widgets/picker_dialog.dart';
import 'audio_cropper_list.dart';

class AudioCropper extends ConsumerWidget {
  const AudioCropper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(trimMusicFileProvider)!;
    return PlatformScaffold(
        appBar: PlatformAppBar(title: AppText("Trim The Audio")),
        body: ListView(shrinkWrap: true, physics: Get.scrollPhysics, children: [
          AudioCropperView(file),
          10.verticalGap,
          Consumer(
            builder: (context, ref, child) {
              if (ref.watch(croppedFileProvider) == null) {
                final cropperNotifier =
                    ref.watch(cropperNotifierProvider(file));
                return Padding(
                  padding: 10.allPad,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 130.wt,
                          child: AppButton(
                              onTap: () async {
                                showMusicPickerDialog();
                              },
                              buttonColor: AppColors.titleColor,
                              text: "Pick Music")),
                      SizedBox(
                        width: 130.wt,
                        child: AppButton(
                            onTap: () async {
                              final croppedFile = await cropperNotifier.trim();
                              ref.read(croppedFileProvider.notifier).state =
                                  croppedFile;
                            },
                            buttonColor: Colors.teal,
                            text: "Trim"),
                      ),
                    ],
                  ),
                );
              }
              return ConfirmButton();
            },
          ),
          AudioCropperList()
        ]));
  }
}
