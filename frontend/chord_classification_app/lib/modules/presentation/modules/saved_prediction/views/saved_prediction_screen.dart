import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../widgets/audio_players/audio_player.dart';
import '../../../widgets/text/app_text.dart';
import '../../chord_prediction/view/amplitude_graph_view.dart';
import '../../chord_prediction/view/graph_view.dart';
import '../../chord_prediction/view/prediction_grid_view.dart';
import '../../chord_prediction/view/speed_controller_view.dart';

class SavedPredictionScreen extends ConsumerWidget {
  const SavedPredictionScreen(this.audioFile, {super.key});

  final File audioFile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: AppText("Chord Classification")),
      body: ListView(
          shrinkWrap: true,
          padding: 10.allPad,
          physics: ClampingScrollPhysics(),
          children: [
            AudioPlayer(audioFile, isCache: true),
            SizedBox(height: 120.ht, child: AmplitudeGraphView(audioFile)),
            5.verticalGap,
            GraphView(audioFile),
            SpeedControllerSlider(audioFile),
            AppText("Chords"),
            5.verticalGap,
            PredictionGridView(audioFile)
          ]),
    );
  }
}
