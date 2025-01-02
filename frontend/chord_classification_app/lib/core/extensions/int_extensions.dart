import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'padding.dart';

extension Intx on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get milliSeconds => Duration(milliseconds: this);
  Duration get microSeconds => Duration(microseconds: this);
}

extension SizeExtensions on int {
  SizedBox get verticalGap {
    final height = this;
    return height.verticalSpace;
  }

  SizedBox get horizontalGap {
    final width = this;
    return width.horizontalSpace;
  }

  double get ht {
    final height = this;
    return height.h;
  }

  double get wt {
    final width = this;
    return width.w;
  }

  double get rt {
    final radius = this;
    return radius.r;
  }

  double get st {
    final spT = this;
    return spT.sp;
  }
}

extension PaddingX on int {
  EdgeInsetsGeometry get horizontalPad =>
      EdgeInsets.symmetric(horizontal: double.parse('$this')).rt;
  EdgeInsetsGeometry get verticalPad =>
      EdgeInsets.symmetric(vertical: double.parse('$this')).rt;
  EdgeInsetsGeometry get allPad => EdgeInsets.all(double.parse('$this')).rt;

  EdgeInsetsGeometry get leftPad =>
      EdgeInsets.only(left: double.parse('$this')).rt;
  EdgeInsetsGeometry get rightPad =>
      EdgeInsets.only(right: double.parse('$this')).rt;
  EdgeInsetsGeometry get topPad =>
      EdgeInsets.only(top: double.parse('$this')).rt;
  EdgeInsetsGeometry get bottomPad =>
      EdgeInsets.only(bottom: double.parse('$this')).rt;
}
