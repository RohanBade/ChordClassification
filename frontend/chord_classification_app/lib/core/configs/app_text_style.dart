import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../extensions/int_extensions.dart';
import '../extensions/textstyle_extensions.dart';

final class AppTextStyles {
  AppTextStyles._();

  /// AppText style for large body text
  static final TextStyle bodyLarge =
      GoogleFonts.workSans(fontWeight: FontWeight.w700).px20;

  //AppText style for body text
  static final TextStyle bodyMedium =
      GoogleFonts.merriweather(fontWeight: FontWeight.w600).px16;

//AppText style for extrasmall body
  static final TextStyle bodySmall =
      GoogleFonts.merriweather(fontWeight: FontWeight.w600).px14;

  static final TextStyle animatedStyle =
      GoogleFonts.dancingScript(fontSize: 30.st);
}
