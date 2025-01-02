import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../injection_container.dart';
import '../../../widgets/buttons/text_buttons.dart';
import '../../../widgets/text/app_text.dart';
import '../../auth/view/login_page.dart';
import '../providers/music_notifier_provider.dart';
import 'chord_prediction_view.dart';
import 'music_selection_view.dart';

class PredictionHomescreen extends ConsumerWidget {
  const PredictionHomescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(musicFileProvider) != null;
    final hasLogin = ref.watch(tokenManagerProvider).token != null;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const AppText("Chord Classification"),
        trailingActions: [
          if (!hasLogin)
            AppTextButton(text: "Login", onPressed: () => Get.to(LoginPage()))
        ],
      ),
      body: AnimatedSwitcher(
          duration: 1.seconds,
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: isSelected ? ChordPredictionView() : MusicSelectionView()),
    );
  }
}
