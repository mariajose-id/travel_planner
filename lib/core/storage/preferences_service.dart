import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._();
  factory PreferencesService() => _instance;
  PreferencesService._();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _keyLanguage = 'language';
  static const String _keyTheme = 'theme';
  static const String _keyIsLoggedIn = 'is_logged_in';

  Future<void> saveLanguage(int index) async {
    await _prefs.setInt(_keyLanguage, index);
  }

  Future<int> getLanguage() async {
    return _prefs.getInt(_keyLanguage) ?? 0;
  }

  Future<void> saveTheme(bool isDark) async {
    await _prefs.setBool(_keyTheme, isDark);
  }

  Future<bool> getTheme() async {
    return _prefs.getBool(_keyTheme) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_keyIsLoggedIn, value);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
