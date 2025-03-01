import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/file_handlers/file_handler.dart';
import '../../../../../core/services/get.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../chord_prediction/providers/music_notifier_provider.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({super.key, required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(title: Text(title), content: content, actions: [
      PlatformDialogAction(
        child: Text("Cancel"),
        onPressed: () => Get.pop(),
        cupertino: (context, platform) =>
            CupertinoDialogActionData(isDestructiveAction: true),
      )
    ]);
  }
}

showMusicPickerDialog() async {
  await showPlatformDialog(
      context: Get.context,
      builder: (context) => AppAlertDialog(
          title: "Pick Music Source",
          content: Padding(
              padding: 10.verticalPad,
              child: Consumer(
                builder: (context, ref, child) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: AppButton(
                              onTap: () async {
                                final file = await FileHandler.getMusicFile();
                                if (file != null) {
                                  ref
                                      .read(trimMusicFileProvider.notifier)
                                      .state = file;
                                  Get.pop();
                                }
                              },
                              text: "Audio"),
                        ),
                        SizedBox(
                          width: 100,
                          child: AppButton(
                              onTap: () async {
                                final file = await FileHandler.getVideoFile();
                                if (file != null) {
                                  ref
                                      .read(trimMusicFileProvider.notifier)
                                      .state = file;
                                  Get.pop();
                                }
                              },
                              text: "Video"),
                        )
                      ]);
                },
              ))));
}
