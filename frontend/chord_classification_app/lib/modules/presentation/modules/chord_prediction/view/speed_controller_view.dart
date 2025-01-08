import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';
import '../../../widgets/text/app_text.dart';

class SpeedControllerSlider extends ConsumerWidget {
  const SpeedControllerSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicNotifier = ref.watch(chordPredictionNotifier);
    final speedValue = musicNotifier.speed;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 5,
          child: PlatformSlider(
              value: speedValue,
              onChanged: (x) => musicNotifier.updateSpeed(x),
              divisions: 7,
              min: 0.25,
              max: 2),
        ),
        Expanded(child: AppText("${speedValue}x")),
      ],
    );
  }
}
