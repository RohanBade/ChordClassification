import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../injection_container.dart';
import '../../../widgets/text/app_text.dart';
import '../widgets/saved_list_tile.dart';

class SavedPredictionView extends ConsumerWidget {
  const SavedPredictionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localSavedNotifier = ref.watch(savedClassificationProvider);
    final localSaved = localSavedNotifier.chords;
    return localSaved.isEmpty
        ? Center(child: AppText("No Saved Files"))
        : ReorderableListView.builder(
            physics: Get.scrollPhysics,
            shrinkWrap: true,
            itemCount: localSaved.length,
            itemBuilder: (context, index) {
              final chord = localSaved[index];
              return Slidable(
                  key: ValueKey(chord),
                  closeOnScroll: true,
                  direction: Axis.horizontal,
                  endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      openThreshold: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (_) =>
                              localSavedNotifier.deleteChord(index),
                          spacing: 8,
                          autoClose: true,
                          padding: EdgeInsets.symmetric(vertical: 5.rt),
                          backgroundColor: AppColors.red,
                          foregroundColor: Colors.white,
                          icon: AppIcons.delete,
                          borderRadius: BorderRadius.circular(10.rt),
                          label: 'Delete',
                        ),
                      ]),
                  child: SavedListTile(chord));
            },
            onReorder: localSavedNotifier.reOrder,
          );
  }
}
