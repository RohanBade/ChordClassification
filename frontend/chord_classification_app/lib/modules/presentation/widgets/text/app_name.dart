import 'package:flutter/material.dart';

import '../../../../core/configs/app_colors.dart';
import 'gradienttext.dart';

class AppName extends StatelessWidget {
  const AppName({super.key, this.fontsize = 30});

  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GradientText(
          gradient:
              const LinearGradient(colors: [Colors.teal, AppColors.primary]),
          text: "Chord Classification",
          fontSize: fontsize),
    );
  }
}