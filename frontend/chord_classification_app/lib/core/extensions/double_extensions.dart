import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'extensions.dart';

extension Double on double {
  Duration get hours => _getDuration(this);
  Duration get minutes => _getDuration(this, feature: "min");
  Duration get seconds => _getDuration(this, feature: 'sec');
  Duration get milliSeconds => _getDuration(this, feature: 'ms');
}

extension SizeExtensionsD on double {
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

extension PaddingXDouble on double {
  EdgeInsetsGeometry get horizontalPad =>
      EdgeInsets.symmetric(horizontal: this).rt;
  EdgeInsetsGeometry get verticalPad => EdgeInsets.symmetric(vertical: this).rt;
  EdgeInsetsGeometry get allPad => EdgeInsets.all(this).rt;

  EdgeInsetsGeometry get leftPad => EdgeInsets.only(left: this).rt;
  EdgeInsetsGeometry get rightPad => EdgeInsets.only(right: this).rt;
  EdgeInsetsGeometry get topPad => EdgeInsets.only(top: this).rt;
  EdgeInsetsGeometry get bottomPad => EdgeInsets.only(bottom: this).rt;
}

Duration _getDuration(double time, {String feature = "sec"}) {
  final intPart = time.truncate();
  final decimalPart = time - intPart;
  switch (feature) {
    case 'hour':
      return Duration(hours: intPart, minutes: (decimalPart * 60).round());
    case 'min':
      return Duration(minutes: intPart, seconds: (decimalPart * 60).round());
    case 'sec':
      return Duration(
          seconds: intPart, milliseconds: (decimalPart * 1000).round());
    case 'ms':
      return Duration(
          milliseconds: intPart, microseconds: (decimalPart * 1000).round());
    default:
      return Duration(
          seconds: intPart, milliseconds: (decimalPart * 1000).round());
  }
}
