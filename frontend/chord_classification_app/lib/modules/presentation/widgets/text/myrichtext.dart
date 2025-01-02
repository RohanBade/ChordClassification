import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/configs/app_colors.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/services/get.dart';

class Myrich extends StatelessWidget {
  const Myrich(
      {super.key,
      required this.prefix,
      this.suffix,
      this.prefixColor,
      this.suffixcolor,
      this.onTap,
      this.prefixStyle,
      this.suffixStyle});

  final dynamic prefix;
  final String? suffix;
  final Color? prefixColor;
  final Color? suffixcolor;
  final VoidCallback? onTap;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
        maxLines: 1,
        TextSpan(
            text: '${prefix.toString().emoji}\t',
            style: prefixStyle ??
                Get.bodyMedium.px12
                    .copyWith(color: prefixColor ?? Get.disabledColor.o6),
            children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                  text: (suffix ?? "").emoji,
                  style: suffixStyle ??
                      Get.bodyMedium.px12
                          .copyWith(color: suffixcolor ?? AppColors.red))
            ]));
  }
}
