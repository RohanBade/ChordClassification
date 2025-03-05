import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../domain/entities/local_chord_model/local_chord_prediction.dart';
import '../../../../injection_container.dart';
import '../../../widgets/buttons/icon_buttons.dart';
import '../../../widgets/text/app_text.dart';
import '../../chord_prediction/view/graph_view.dart';
import '../views/saved_prediction_screen.dart';

class SavedListTile extends ConsumerWidget {
  const SavedListTile(this.chord, {super.key});

  final LocalChord chord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chordNotifier = ref.watch(chordPredictionNotifier(chord.file!));
    final duration = (chordNotifier.currentTime).roundOff3;
    return ListTile(
      onTap: () {
        chordNotifier.updateAmplitudeData();
        Get.to(SavedPredictionScreen(chord.file!));
      },
      title: AppText(chord.fileName, fontSize: 14),
      subtitle: AppText(
          "\t\t$duration : ${chordNotifier.duration.roundOff3} sec",
          style: Get.bodySmall.px10.w200),
      leading: AppIcon(chordNotifier.isPlaying ? AppIcons.pause : AppIcons.play,
          onTap: () => chordNotifier.updateIsPlaying()),
      trailing: AbsorbPointer(
        absorbing: true,
        child:
            Card(elevation: 8, child: FittedBox(child: GraphView(chord.file!))),
      ),
    );
  }
}
