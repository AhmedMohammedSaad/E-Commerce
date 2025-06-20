// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AppLanguage {
  english,
  arabic,
}

class LanguageManager {
  static const String ENGLISH = 'en';
  static const String ARABIC = 'ar';

  static const String ASSETS_PATH = 'assets/translations';
  static const Locale ENGLISH_LOCALE = Locale('en');
  static const Locale ARABIC_LOCALE = Locale('ar');

  static const Locale DEFAULT_LOCALE = ARABIC_LOCALE;
  static const List<Locale> SUPPORTED_LOCALES = [
    ENGLISH_LOCALE,
    ARABIC_LOCALE,
  ];

  static Locale getLocale(String languageCode) {
    switch (languageCode) {
      case ENGLISH:
        return ENGLISH_LOCALE;
      case ARABIC:
        return ARABIC_LOCALE;
      default:
        return DEFAULT_LOCALE;
    }
  }

  static String getLanguageName(BuildContext context, String languageCode) {
    switch (languageCode) {
      case ENGLISH:
        return 'English';
      case ARABIC:
        return 'العربية';
      default:
        return 'English';
    }
  }

  static bool isRTL(BuildContext context) {
    return Localizations.localeOf(context).languageCode == ARABIC;
  }
}
