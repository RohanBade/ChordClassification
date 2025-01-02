import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../core/extensions/extensions.dart';

class AppListTile extends StatelessWidget {
  const AppListTile(
      {super.key,
      required this.title,
      this.leading,
      this.trailing,
      this.onTap,
      this.subtitle});

  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onTap;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return PlatformListTile(
      title: title,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      subtitle: subtitle,
      cupertino: (context, platform) =>
          CupertinoListTileData(padding: 8.allPad),
    );
  }
}
