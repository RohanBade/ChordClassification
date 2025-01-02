import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/get.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key, this.color});

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return PlatformCircularProgressIndicator(
      material: (context, platform) => MaterialProgressIndicatorData(
          key: key, color: color ?? Get.primaryColor, strokeWidth: 2.sp),
      cupertino: (context, platform) => CupertinoProgressIndicatorData(
          radius: 10.sp,
          key: key,
          color: color ?? Get.primaryColor,
          animating: true),
    );
  }
}
