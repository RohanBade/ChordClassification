import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:typewritertext/typewritertext.dart';
import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';

import '../../../../../core/services/get.dart';
import '../../../widgets/text/gradienttext.dart';
import '../../homepage/views/homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0).rt,
        child: Center(
          child: TypeWriter(
              controller: TypeWriterController(
                  text: "WelCome\nto\n\tChord Classification",
                  duration: 70.milliSeconds),
              onFinished: (value) => Get.offAll(Homepage()),
              builder: (context, controller) {
                return GradientText(
                    gradient: const LinearGradient(colors: [
                      Colors.teal,
                      AppColors.primary,
                      Colors.green,
                    ]),
                    fontSize: 45,
                    text: controller.text);
              }),
        ),
      ),
    );
  }
}
