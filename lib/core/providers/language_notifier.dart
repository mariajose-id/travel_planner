import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'Initialize SharedPreferences in ProviderScope overrides',
  );
});

final languageProvider = NotifierProvider<LanguageNotifier, Locale>(
  LanguageNotifier.new,
);

class LanguageNotifier extends Notifier<Locale> {
  static const String _languageKey = 'selected_language';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    return Locale(languageCode);
  }

  Future<void> changeLanguage(String languageCode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_languageKey, languageCode);
    state = Locale(languageCode);
  }
}
