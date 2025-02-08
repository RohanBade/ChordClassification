import 'package:flutter/material.dart';

import 'storage_services.dart';

abstract class ThemeNotifier extends ChangeNotifier {
  ThemeMode get themeMode;
  bool get isDark;

  Future<ThemeNotifier> init(StorageServices box);

  void toggleTheme();
}
