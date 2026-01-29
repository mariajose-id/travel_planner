import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_planner/core/theme/app_theme.dart';
class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'selected_theme';
  bool _isDarkMode = false;
  ThemeMode _themeMode = ThemeMode.system;
  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    
    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          _themeMode = ThemeMode.light;
          _isDarkMode = false;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          _isDarkMode = true;
          break;
        default:
          _themeMode = ThemeMode.system;
          _isDarkMode = false;
      }
    }
    
    notifyListeners();
  }
  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = mode;
    
    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        _isDarkMode = false;
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        _isDarkMode = true;
        break;
      case ThemeMode.system:
        themeString = 'system';
        _isDarkMode = false;
        break;
    }
    
    await prefs.setString(_themeKey, themeString);
    notifyListeners();
  }
  Future<void> toggleTheme() async {
    switch (_themeMode) {
      case ThemeMode.light:
        await setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        await setThemeMode(ThemeMode.system);
        break;
      case ThemeMode.system:
        await setThemeMode(ThemeMode.light);
        break;
    }
  }
  String get currentThemeLabel {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
  IconData get currentThemeIcon {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
  Color get currentThemeColor {
    switch (_themeMode) {
      case ThemeMode.light:
        return Colors.orange;
      case ThemeMode.dark:
        return const Color(0xFFE91E63);
      case ThemeMode.system:
        return Colors.blue;
    }
  }
}
