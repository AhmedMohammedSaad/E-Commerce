// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/features/auth/presentation/screen/sign_in.dart';
import 'package:advanced_app/features/onboarding/presentation/screen/onboarding.dart';
import 'package:flutter/material.dart';

class RouteManager {
  //! Route names
  static const String onboarding = '/onboarding';
  static const String signIn = '/signIn';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String about = '/about';

  //! Route generator method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => Onboarding());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignIn());
      // case signup:
      //   return MaterialPageRoute(builder: (_) => Signup());
      // case profile:
      //   return MaterialPageRoute(builder: (_) => ProfilePage());
      // case settings:
      //   return MaterialPageRoute(builder: (_) => SettingsPage());
      // case about:
      //   return MaterialPageRoute(builder: (_) => AboutPage());
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
