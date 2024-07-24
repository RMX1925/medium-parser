import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool isDarkTheme(BuildContext context) {
    return _isDarkTheme;
  }

  ThemeData currentTheme(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark || _isDarkTheme) {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }

  void resetTheme(BuildContext context) {
    _isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
