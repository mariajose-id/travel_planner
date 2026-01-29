import 'package:flutter/material.dart';
import 'package:travel_planner/core/localization/country_code_to_emoji.dart';
class AppLanguages {
  static const List<LanguageInfo> all = [
    LanguageInfo(
      code: 'en',
      countryCode: 'US',
      nativeName: 'English',
    ),
    LanguageInfo(
      code: 'es',
      countryCode: 'ES',
      nativeName: 'Español',
    ),
    LanguageInfo(
      code: 'id',
      countryCode: 'ID',
      nativeName: 'Indonesia',
    ),
  ];
  
  static LanguageInfo? get(String code) {
    return all.firstWhere((lang) => lang.code == code);
  }
  
  static List<Locale> get supportedLocales {
    return all.map((lang) => Locale(lang.code)).toList();
  }
  
  static LanguageInfo? fromLocale(Locale locale) {
    return all.firstWhere((lang) => lang.code == locale.languageCode);
  }
}
class LanguageInfo {
  final String code;
  final String countryCode;
  final String nativeName;
  
  String get emoji => CountryCodeToEmoji.convert(countryCode);
  const LanguageInfo({
    required this.code,
    required this.countryCode,
    required this.nativeName,
  });
}
