import 'package:advanced_app/app/myapp.dart';
import 'package:advanced_app/core/bloc/bolc_obsirver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://uvedejatxeoieqysxkbc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2ZWRlamF0eGVvaWVxeXN4a2JjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxNjM2NDMsImV4cCI6MjA1MTczOTY0M30.56joH_0BkVZ-Ew3qbOiuH7l1sa6jozfRTV0oB9l0HEo',
  );
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}
