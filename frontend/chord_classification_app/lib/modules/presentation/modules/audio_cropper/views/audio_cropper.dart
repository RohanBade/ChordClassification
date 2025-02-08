import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../../widgets/text/app_text.dart';
import '../dependency_injection/audio_injection.dart';
import '../widgets/audio_trimmer_widget.dart';
import '../widgets/confirm_button.dart';
import 'audio_cropper_list.dart';

class AudioCropper extends StatelessWidget {
  const AudioCropper(this.file, {super.key});
  final File file;
  @override
  Widget build(BuildContext context) {
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
                  child: AppButton(
                      onTap: () async {
                        final croppedFile = await cropperNotifier.trim();
                        ref.read(croppedFileProvider.notifier).state =
                            croppedFile;
                      },
                      buttonColor: Colors.teal,
                      text: "Trim"),
                );
              }
              return ConfirmButton(file);
            },
          ),
          AudioCropperList()
        ]));
  }
}
