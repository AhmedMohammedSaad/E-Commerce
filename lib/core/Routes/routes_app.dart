// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/features/auth/presentation/screen/forgot_pass.dart';
import 'package:advanced_app/features/auth/presentation/screen/new_pass.dart';
import 'package:advanced_app/features/auth/presentation/screen/sign_in.dart';
import 'package:advanced_app/features/auth/presentation/screen/sign_up.dart';
import 'package:advanced_app/features/home/presentation/pages/home.dart';
import 'package:advanced_app/features/nav_bar/page/nav_bar.dart';
import 'package:advanced_app/features/onboarding/presentation/screen/onboarding.dart';
import 'package:advanced_app/features/onboarding/presentation/screens/boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:advanced_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:advanced_app/core/animations/page_transitions.dart';

class RouteManager {
  //! Route names
  static const String onboarding = '/onboarding';
  static const String signIn = '/signIn';
  static const String singUP = '/singUP';
  static const String forgotPass = '/forgotPass';
  static const String home = '/home';
  static const String newPass = '/newPass';
  static const String navBar = '/navBar';
  static const String splashScreen = '/splashScreen';
  static const String dashboard = '/dashboard';

  //! Route generator method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return CustomPageTransition(
          child: BoardingScreen(),
          transitionType: TransitionType.fade,
        );
      case signIn:
        return CustomPageTransition(
          child: SignIn(),
          transitionType: TransitionType.slideRight,
        );
      case singUP:
        return CustomPageTransition(
          child: SingUP(),
          transitionType: TransitionType.slideRight,
        );
      case forgotPass:
        return CustomPageTransition(
          child: ForgotPass(),
          transitionType: TransitionType.slideUp,
        );
      case newPass:
        return CustomPageTransition(
          child: NewPass(),
          transitionType: TransitionType.slideUp,
        );
      case home:
        return CustomPageTransition(
          child: Home(),
          transitionType: TransitionType.fade,
        );
      case navBar:
        return CustomPageTransition(
          child: NavBar(),
          transitionType: TransitionType.fade,
        );
      case dashboard:
        return CustomPageTransition(
          child: const DashboardPage(),
          transitionType: TransitionType.slideRight,
        );
      // case splashScreen:
      //   return MaterialPageRoute(builder: (_) => SplashScreen());

      default:
        return CustomPageTransition(
          child: BoardingScreen(),
          transitionType: TransitionType.fade,
        );
    }
  }
}
