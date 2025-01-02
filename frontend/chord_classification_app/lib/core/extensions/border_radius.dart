
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Centralization of ScreenUtil

extension ResponsiveBorder on BorderRadius{
    BorderRadius get rt {
    final bRadius = this;
    return bRadius.r;
  }
}