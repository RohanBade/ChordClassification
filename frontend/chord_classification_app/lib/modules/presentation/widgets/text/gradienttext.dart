import 'package:flutter/material.dart';
import '../../../../core/configs/app_text_style.dart';
import 'app_text.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      {super.key,
      required this.gradient,
      required this.text,
      this.style,
      this.textAlign,
      this.fontSize = 35});

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final double fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: AppText(text,
            style: style ?? AppTextStyles.animatedStyle,
            fontSize: fontSize,
            textAlign: TextAlign.center));
  }
}
