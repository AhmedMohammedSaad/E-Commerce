import 'package:advanced_app/core/Routes/routes_app.dart';
import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/theme/app_theme.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Brando extends StatelessWidget {
  const Brando._privateConstructor();
  static const Brando _instance = Brando._privateConstructor();
  factory Brando() => _instance;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        final SupabaseClient supabase = Supabase.instance.client;
        return BlocProvider(
          create: (context) => ShopCubit(apiConsumer: DioConsumer()),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Brando',
            theme: LightTheme.theme,
            initialRoute: supabase.auth.currentUser != null
                ? RouteManager.navBar
                : RouteManager.onboarding,
            onGenerateRoute: RouteManager.generateRoute,
          ),
        );
      },
    );
  }
}
