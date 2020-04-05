import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// light theme
ThemeData light = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(color: Colors.white.withOpacity(0.1)),
  scaffoldBackgroundColor: Colors.white.withOpacity(0.91),
);

// dark theme
ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  iconTheme: IconThemeData(color: Colors.white),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _preferences;
  bool _isDark;

// getter
  bool get isDark => _isDark;

  ThemeNotifier() {
    _isDark = true; // default value
    _loadFromPrefs();
  }

// function to change the theme
  toggleTheme() {
    _isDark = !_isDark;
    _savedToPrefs();
    notifyListeners();
  }

// initiating SharedPreferences
  _initPrefs() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

// loading saved preferences
  _loadFromPrefs() async {
    await _initPrefs();
    _isDark = _preferences.getBool(key) ?? true;
    notifyListeners();
  }

// saving to preferences
  _savedToPrefs() async {
    await _initPrefs();
    _preferences.setBool(key, _isDark);
  }
}
