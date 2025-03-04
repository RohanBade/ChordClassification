import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../chord_prediction/providers/music_notifier_provider.dart';
import '../dependency_injection/audio_injection.dart';

class ContinueWithoutTrimming extends ConsumerWidget {
  const ContinueWithoutTrimming({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(trimMusicFileProvider)!;
    final cropperNotifier = ref.watch(cropperNotifierProvider(file));
    final audioListFiles = ref.watch(cropFileListProvider);
    final toShow = cropperNotifier.continueWithoutTrimming &&
        audioListFiles.croppedFiles.isEmpty;
    return Visibility(
      visible: toShow,
      child: Padding(
          padding: 10.allPad,
          child: AppButton(
              onTap: () {
                ref.read(musicFileProvider.notifier).state = file;
                Get.pop();
              },
              text: "Continue Without Trimming")),
    );
  }
}
