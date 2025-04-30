import 'package:advanced_app/app/myapp.dart';
import 'package:advanced_app/core/apikey.dart';
import 'package:advanced_app/core/bloc/bolc_obsirver.dart';
import 'package:advanced_app/core/localization/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uvedejatxeoieqysxkbc.supabase.co',
    anonKey: apiKey,
  );
  Bloc.observer = MyBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.SUPPORTED_LOCALES,
      path: LanguageManager.ASSETS_PATH,
      fallbackLocale: LanguageManager.DEFAULT_LOCALE,
      child: Brando(),
    ),
  );
}
