import 'package:flutter/material.dart';
import 'package:musique/themes/dark_mode.dart';
import 'package:musique/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = darkMode;

  // get theme
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // is light mode
  bool get isLightMode => _themeData == lightMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // update the ui
    notifyListeners(); 
  }
  // toggle theme
  void toggleTheme () {
    if (isLightMode) {
      themeData = darkMode;
    }
    else {
      themeData = lightMode;
    }
  }
}