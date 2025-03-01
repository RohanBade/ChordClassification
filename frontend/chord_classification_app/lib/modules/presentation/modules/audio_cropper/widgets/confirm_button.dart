import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../dependency_injection/audio_injection.dart';
import 'audio_trimmer_widget.dart';

class ConfirmButton extends ConsumerWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trimmedFile = ref.watch(croppedFileProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        5.verticalGap,
        Divider(),
        5.verticalGap,
        AudioCropperView(trimmedFile!,
            color: const Color.fromARGB(255, 189, 13, 71)),
        10.verticalGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppButton(
                onTap: () => ref.invalidate(croppedFileProvider),
                text: "  Remove  ",
                buttonColor: AppColors.red),
            AppButton(
                onTap: () async {
                  await ref
                      .read(cropperNotifierProvider(trimmedFile))
                      .confirm();
                },
                buttonColor: Colors.teal,
                text: " Confirm "),
          ],
        )
      ],
    );
  }
}
