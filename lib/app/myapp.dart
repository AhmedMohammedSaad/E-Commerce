import 'package:advanced_app/core/Routes/routes_app.dart';
import 'package:advanced_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp._privateConstructor();
  static const MyApp _instance = MyApp._privateConstructor();
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerse App',
          theme: LightTheme.theme,
          initialRoute: RouteManager.splashScreen,
          onGenerateRoute: RouteManager.generateRoute,
        );
      },
    );
  }
}
