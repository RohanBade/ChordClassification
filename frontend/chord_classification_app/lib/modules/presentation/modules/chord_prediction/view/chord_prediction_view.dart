import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../widgets/audio_players/audio_player.dart';
import '../../../widgets/error_handler/error_button.dart';
import '../../../widgets/progressindicators/app_progress_indicators.dart';
import '../../../widgets/text/app_text.dart';
import '../providers/chord_prediction_provider.dart';
import '../providers/music_notifier_provider.dart';
import 'amplitude_graph_view.dart';
import 'graph_view.dart';
import 'prediction_grid_view.dart';
import 'speed_controller_view.dart';

class ChordPredictionView extends ConsumerWidget {
  const ChordPredictionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioFile = ref.watch(musicFileProvider);
    final chordPrediction = ref.watch(chordPredictionProvider(audioFile!));
    return ListView(
        shrinkWrap: true,
        padding: 10.allPad,
        physics: ClampingScrollPhysics(),
        children: [
          chordPrediction.when(
              skipLoadingOnRefresh: false,
              error: (error, stackTrace) =>
                  ErrorButton(provider: chordPredictionProvider),
              loading: () => Center(child: AppProgressIndicator()),
              data: (predictions) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AudioPlayer(audioFile, key: Get.key(audioFile)),
                    SizedBox(
                        height: 120.ht, child: AmplitudeGraphView(audioFile)),
                    5.verticalGap,
                    GraphView(audioFile),
                    SpeedControllerSlider(audioFile),
                    AppText("Chords"),
                    5.verticalGap,
                    PredictionGridView(audioFile)
                  ],
                );
              }),
        ]);
  }
}
