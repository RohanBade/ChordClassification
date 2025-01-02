import 'package:flutter/material.dart';

import '../../../abstractservices/storage_services.dart';
import '../../utils/storage_key_constants.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(this._storageServices);
  final StorageServices _storageServices;

  bool isDark = false;

  Future<ThemeNotifier> init() async {
    final index = await _storageServices.get(StorageKeys.themeIndex) ?? 0;
    isDark = index == 1;
    return this;
  }

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDark = !isDark;
    _storageServices.set(StorageKeys.themeIndex, isDark ? 1 : 0);
    notifyListeners();
  }
}
