import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';
import '../../../widgets/error_handler/error_button.dart';
import '../../../widgets/progressindicators/app_progress_indicators.dart';
import '../../../widgets/text/app_text.dart';
import 'saved_prediction_view.dart';

class SavedPredictionInitView extends ConsumerWidget {
  const SavedPredictionInitView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPredictions = ref.watch(fetchSavedDataProvider);
    return PlatformScaffold(
      appBar: PlatformAppBar(title: AppText("Saved Music")),
      body: savedPredictions.when(
          error: (error, stackTrace) =>
              ErrorButton(provider: fetchSavedDataProvider),
          loading: () => Center(child: AppProgressIndicator()),
          data: (data) => SavedPredictionView()),
    );
  }
}
