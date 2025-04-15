import 'package:advanced_app/app/myapp.dart';
import 'package:advanced_app/core/apikey.dart';
import 'package:advanced_app/core/bloc/bolc_obsirver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(  
    url: 'https://uvedejatxeoieqysxkbc.supabase.co',
    anonKey: apiKey,
  );
  Bloc.observer = MyBlocObserver();

  runApp(Brando());
}
