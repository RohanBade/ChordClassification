import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../injection_container.dart';
import '../../../widgets/text/app_text.dart';

class PredictionGridView extends ConsumerWidget {
  const PredictionGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chordNotifier = ref.watch(chordPredictionNotifier);
    final predictions = chordNotifier.chordPredictions;
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      shrinkWrap: true,
      physics: Get.scrollPhysics,
      itemCount: predictions.length,
      itemBuilder: (context, index) {
        final prediction = predictions[index];
        final isCurrentChord = index == chordNotifier.currentIndex;
        final selectedColor = isCurrentChord ? chordNotifier.color : null;
        final textColor = isCurrentChord ? AppColors.white : null;
        return GestureDetector(
          onTap: () => chordNotifier.seekTo(prediction.start),
          onDoubleTap: () => chordNotifier.playTheChord(prediction.start),
          onLongPress: () => chordNotifier.playTheChord(prediction.start),
          child: Card(
              key: Get.key(prediction),
              shadowColor: selectedColor,
              color: selectedColor?.o6,
              elevation: isCurrentChord ? 8 : 0,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10).rt,
                  side: BorderSide(color: Get.disabledColor)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(prediction.chord, fontSize: 14, textColor: textColor),
                  5.verticalGap,
                  AppText("${prediction.start}-${prediction.end} Sec",
                      fontSize: 12, textColor: textColor),
                  if (isCurrentChord && chordNotifier.isPlaying)
                    LoadingAnimationWidget.waveDots(
                        color: textColor!, size: 15.st)
                ],
              )),
        );
      },
    );
  }
}
