import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../injection_container.dart';
import '../../../widgets/buttons/icon_buttons.dart';

class SavedIcon extends ConsumerWidget {
  const SavedIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const icon = AppIcon(AppIcons.save, size: 20);
    final savedPredictions = ref.watch(fetchSavedDataProvider);
    return savedPredictions.when(
        data: (data) => icon,
        error: (error, stackTrace) => icon,
        loading: () => icon);
  }
}
