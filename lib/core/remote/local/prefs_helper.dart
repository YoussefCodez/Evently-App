import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      prefs.setString("themeMode", "light");
    } else {
      prefs.setString("themeMode", "dark");
    }
  }

  static ThemeMode getThemeMode() {
    return prefs.getString("themeMode") == "dark"
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}