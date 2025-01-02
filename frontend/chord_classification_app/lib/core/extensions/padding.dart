import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Centralization of ScreenUtil

extension ResponsivePadding on EdgeInsets {
  EdgeInsetsGeometry get rt {
    final edgePad = this;
    return edgePad.r;
  }
}
