import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../core/configs/app_colors.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/services/get.dart';
import '../progressindicators/app_progress_indicators.dart';
import '../text/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.buttonColor,
      this.radius = 10,
      this.textColor,
      this.height = 40,
      this.width});
  final String text;
  final dynamic Function() onTap;
  final Color? buttonColor, textColor;
  final double radius;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(radius).rt;
    final loadingNotifier = ValueNotifier(false);
    return SizedBox(
      height: height?.ht,
      width: width?.wt,
      child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (context, value, child) => AbsorbPointer(
                absorbing: value,
                child: PlatformElevatedButton(
                    onPressed: () async {
                      try {
                        FocusScope.of(context).unfocus();
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                      loadingNotifier.value = true;
                      await onTap.call();
                      loadingNotifier.value = false;
                    },
                    color: buttonColor,
                    material: (context, platform) => MaterialElevatedButtonData(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: border.rt))),
                    cupertino: (context, platform) =>
                        CupertinoElevatedButtonData(
                            padding: 8.horizontalPad,
                            pressedOpacity: 0.7,
                            color: buttonColor,
                            borderRadius: border.rt),
                    child: value
                        ? const AppProgressIndicator(color: AppColors.white)
                        : AppText(text,
                            style: Get.bodyMedium.white, maxLines: 1)),
              )),
    );
  }
}
