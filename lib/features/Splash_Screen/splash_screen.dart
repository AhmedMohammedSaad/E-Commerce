// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      final SupabaseClient supabase = Supabase.instance.client;
      if (supabase.auth.currentUser != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/navBar', (Route<dynamic> route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/onboarding', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logoBrando.gif',
          width: 700.w,
          height: 600.h,
        ),
      ),
    );
  }
}
