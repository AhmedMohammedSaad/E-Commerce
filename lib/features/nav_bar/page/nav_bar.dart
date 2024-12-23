// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Shop/presentation/pages/shop.dart';
import 'package:advanced_app/features/home/presentation/pages/home.dart';
import 'package:advanced_app/features/nav_bar/cubit/navebarsd_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final List widgetChangeIndex = [
    Home(),
    Shop(),
    Center(child: Text("333")),
    Center(child: Text("444")),
    Center(child: Text("555")),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavebarsdCubit(),
      child: BlocBuilder<NavebarsdCubit, NavebarsdState>(
        builder: (context, state) {
          //  NavebarsdCubit indexChange = context.read<NavebarsdCubit>();
          return Scaffold(
            //! widget home  and > shop and favorite and profile ........
            body: widgetChangeIndex[context.read<NavebarsdCubit>().courntIndex],
            //!__________________________________________
            //! botton Nav_ bar
            bottomNavigationBar: GNav(
                onTabChange: (index) {
                  context.read<NavebarsdCubit>().changeCourntIndex(index);
                },
                backgroundColor: ColorManager.white,
                duration: Duration(milliseconds: 400),
                gap: 3,
                color: ColorManager.grey,
                tabBackgroundColor: ColorManager.green,
                activeColor: ColorManager.white, // selected icon and text color
                iconSize: 24,
                tabMargin:
                    EdgeInsets.symmetric(vertical: 18.h, horizontal: 3.w),
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w, vertical: 12.h), // navigation bar padding
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.shopify_rounded,
                    text: 'Shop',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favorite',
                  ),
                  GButton(
                    icon: Icons.shopping_cart_outlined,
                    text: 'Cartj',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  )
                ]),
          );
        },
      ),
    );
  }
}
