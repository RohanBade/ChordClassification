import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';
import '../../../widgets/buttons/text_buttons.dart';
import '../providers/music_notifier_provider.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicFile = ref.watch(musicFileProvider);
    if (musicFile == null) {
      return SizedBox.shrink();
    }
    final chordNotifier = ref.watch(chordPredictionNotifier(musicFile));
    if (chordNotifier.chordPredictions.isEmpty) {
      return SizedBox.shrink();
    }
    return AppTextButton(
        text: "Save", onPressed: () => chordNotifier.saveOutputData());
  }
}
