import 'package:flutter/material.dart';

import '../configs/app_colors.dart';
import '../services/get.dart';
import 'extensions.dart';

extension SizeExtension on TextStyle {
  TextStyle get px10 => copyWith(fontSize: 10.st);
  TextStyle get px11 => copyWith(fontSize: 11.st);
  TextStyle get px12 => copyWith(fontSize: 12.st);
  TextStyle get px13 => copyWith(fontSize: 13.st);
  TextStyle get px14 => copyWith(fontSize: 14.st);
  TextStyle get px15 => copyWith(fontSize: 15.st);
  TextStyle get px16 => copyWith(fontSize: 16.st);
  TextStyle get px17 => copyWith(fontSize: 17.st);
  TextStyle get px18 => copyWith(fontSize: 18.st);
  TextStyle get px19 => copyWith(fontSize: 19.st);
  TextStyle get px20 => copyWith(fontSize: 20.st);
  TextStyle get px21 => copyWith(fontSize: 21.st);
  TextStyle get px22 => copyWith(fontSize: 22.st);
  TextStyle get px23 => copyWith(fontSize: 23.st);
  TextStyle get px24 => copyWith(fontSize: 24.st);
  TextStyle get px25 => copyWith(fontSize: 25.st);
  TextStyle get px26 => copyWith(fontSize: 26.st);
  TextStyle get px27 => copyWith(fontSize: 27.st);
  TextStyle get px28 => copyWith(fontSize: 28.st);
  TextStyle get px29 => copyWith(fontSize: 29.st);
  TextStyle get px30 => copyWith(fontSize: 30.st);
  TextStyle get px31 => copyWith(fontSize: 31.st);
  TextStyle get px32 => copyWith(fontSize: 32.st);
  TextStyle get px33 => copyWith(fontSize: 33.st);
  TextStyle get px34 => copyWith(fontSize: 34.st);
  TextStyle get px35 => copyWith(fontSize: 35.st);
  TextStyle get px36 => copyWith(fontSize: 36.st);
  TextStyle get px37 => copyWith(fontSize: 37.st);
  TextStyle get px38 => copyWith(fontSize: 38.st);
  TextStyle get px39 => copyWith(fontSize: 39.st);
  TextStyle get px40 => copyWith(fontSize: 40.st);
  TextStyle get px15o5 => copyWith(fontSize: 15.5.st);
}

extension Boldness on TextStyle {
  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);
}

extension Textcolor on TextStyle {
  TextStyle get primary => copyWith(color: Get.primaryColor);
  TextStyle get disabled => copyWith(color: Get.disabledColor);
  TextStyle get black => copyWith(color: AppColors.black);
  TextStyle get scaffoldBackground =>
      copyWith(color: Get.scaffoldBackgroundColor);
  TextStyle get disabledO5 => copyWith(color: Get.disabledColor.o5);
  TextStyle get primaryO6 => copyWith(color: Get.primaryColor.o6);
  TextStyle get white => copyWith(color: AppColors.white);
  TextStyle get error => copyWith(color: AppColors.red);

  TextStyle get titleColor => copyWith(color: AppColors.titleColor);
}

extension Styling on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get h2 => copyWith(height: 2.ht);
  TextStyle get h1 => copyWith(height: 1.ht);
  TextStyle get h1o5 => copyWith(height: 1.5.ht);
}
