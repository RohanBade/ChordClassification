import 'package:flutter/cupertino.dart';

abstract final class AppColors {
  AppColors._();
  static const Color primary = CupertinoColors.systemBlue;

  static const Color transparent = Color.fromARGB(0, 0, 0, 0);

  static const Color iosBlack = CupertinoColors.darkBackgroundGray;
  static const Color iosWhite = CupertinoColors.extraLightBackgroundGray;

  static const Color black = CupertinoColors.black;
  static const Color white = Color(0xffFFFFFF);

  static const Color cyan = Color(0xff00bcd4);
  static const Color appBarColor = Color(0xff5D2EC0);

  static const Color reddisBrown = Color(0xff904D00);
  static const Color lightOrange = Color(0xffF9D9B5);

  static const Color titleColor = Color(0xff627485);
  static const Color borderColor = Color(0xffDCDCDC);
  static const Color blue = Color(0xff0038FF);

  static const Color red = CupertinoColors.destructiveRed;
}
