import 'package:advanced_app/core/localization/language_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(Locale('en')));

  static const String LANGUAGE_KEY = 'LANGUAGE_KEY';

  Future<void> getSavedLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(LANGUAGE_KEY);

    if (languageCode != null) {
      final Locale locale = LanguageManager.getLocale(languageCode);
      emit(LanguageState(locale));
    }
  }

  Future<void> setLanguage(BuildContext context, String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_KEY, languageCode);

    final Locale locale = LanguageManager.getLocale(languageCode);
    await context.setLocale(locale);
    emit(LanguageState(locale));
  }

  Future<void> toggleLanguage(BuildContext context) async {
    final currentLocale = context.locale;
    final newLanguageCode =
        currentLocale.languageCode == LanguageManager.ENGLISH
            ? LanguageManager.ARABIC
            : LanguageManager.ENGLISH;

    await setLanguage(context, newLanguageCode);
  }
}
