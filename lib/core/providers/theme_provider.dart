import 'package:evently_c17/core/remote/local/prefs_helper.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void initTheme() {
    themeMode = PrefsHelper.getThemeMode();
    notifyListeners();
  }

  void toggleTheme(ThemeMode newMode) {
    themeMode = newMode;
    notifyListeners();
  }
}
