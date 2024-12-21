// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/features/auth/presentation/screen/forgot_pass.dart';
import 'package:advanced_app/features/auth/presentation/screen/new_pass.dart';
import 'package:advanced_app/features/auth/presentation/screen/sign_in.dart';
import 'package:advanced_app/features/auth/presentation/screen/sign_up.dart';
import 'package:advanced_app/features/home/presentation/pages/home.dart';
import 'package:advanced_app/features/onboarding/presentation/screen/onboarding.dart';
import 'package:flutter/material.dart';

class RouteManager {
  //! Route names
  static const String onboarding = '/onboarding';
  static const String signIn = '/signIn';
  static const String singUP = '/singUP';
  static const String forgotPass = '/forgotPass';
  static const String home = '/home';
  static const String newPass = '/newPass';

  //! Route generator method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => Onboarding());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignIn());
      case singUP:
        return MaterialPageRoute(builder: (_) => SingUP());
      case forgotPass:
        return MaterialPageRoute(builder: (_) => ForgotPass());
      case newPass:
        return MaterialPageRoute(builder: (_) => NewPass());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
