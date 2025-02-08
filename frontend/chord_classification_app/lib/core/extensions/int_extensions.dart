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

extension TimeX on int {
  String get timeFormat => _formatTime(this);
  String get timeFormatHrs => _formatTimeHrs(this);
}

String _formatTimeHrs(int milliseconds) {
  int totalSeconds = milliseconds ~/ 1000;
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;
  return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

String _formatTime(int milliseconds) {
  int totalSeconds = milliseconds ~/ 1000;
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;

  if (hours > 0) {
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  } else {
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
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
