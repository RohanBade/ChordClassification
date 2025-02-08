import 'package:flutter/material.dart';

import '../../../abstractservices/storage_services.dart';
import '../../../abstractservices/theme_notifier.dart';
import '../../utils/storage_key_constants.dart';

class ThemeNotifierImpl extends ThemeNotifier {
  late StorageServices _storageServices;

  bool _isDarkTheme = false;

  @override
  get isDark => _isDarkTheme;

  @override
  Future<ThemeNotifier> init(box) async {
    _storageServices = box;
    final index = await _storageServices.get(StorageKeys.themeIndex) ?? 0;
    _isDarkTheme = index == 1;
    return this;
  }

  @override
  ThemeMode get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  @override
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _storageServices.set(StorageKeys.themeIndex, _isDarkTheme ? 1 : 0);
    notifyListeners();
  }
}
