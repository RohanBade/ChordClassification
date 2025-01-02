import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../../../../core/services/get.dart';
import '../../../widgets/listtile/app_list_tile.dart';
import '../../../widgets/text/app_text.dart';

class AppSwitchListTile extends StatelessWidget {
  const AppSwitchListTile(
      {super.key,
      required this.title,
      required this.onChanged,
      this.value = false});

  final String title;
  final void Function(bool)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: AppText(title),
      trailing: Transform.scale(
          scale: Get.isIOS ? 0.7 : 1,
          child: PlatformSwitch(value: value, onChanged: onChanged)),
    );
  }
}
