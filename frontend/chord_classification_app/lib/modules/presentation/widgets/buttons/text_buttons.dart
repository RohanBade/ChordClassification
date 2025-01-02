import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/textstyle_extensions.dart';
import '../../../../core/services/get.dart';
import '../text/app_text.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.style,
      this.padding});

  final String text;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
        onPressed: onPressed,
        padding: padding ?? const EdgeInsets.only(top: 10).r,
        alignment: Alignment.topCenter,
        material: (context, platform) => MaterialTextButtonData(
            clipBehavior: Clip.hardEdge,
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory)),
        child: AppText(text, style: style ?? Get.bodyMedium.primary.px15o5));
  }
}
