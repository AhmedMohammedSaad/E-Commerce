// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Cart/presentation/pages/cart.dart';
import 'package:advanced_app/features/Profile/presentation/pages/profile.dart';
import 'package:advanced_app/features/Shop/presentation/pages/shop.dart';
import 'package:advanced_app/features/home/presentation/pages/home.dart';
import 'package:advanced_app/features/nav_bar/cubit/navebarsd_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Favorite/presentation/pages/favorite.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  final List widgetChangeIndex = [
    Home(),
    Shop(),
    Favorite(),
    Cart(),
    ProfilePage(),
  ];

  // Use late but initialize in init
  late AnimationController _animationController;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();

    // Initialize the controller properly with the state as vsync
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _animationController.forward();
    _isControllerInitialized = true;
  }

  @override
  void didUpdateWidget(NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Ensure animation controller is properly reinitialized after hot reload
    if (!_isControllerInitialized) {
      _initializeAnimationController();
    }
  }

  void _initializeAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _animationController.forward();
    _isControllerInitialized = true;
  }

  @override
  void dispose() {
    if (_isControllerInitialized) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavebarsdCubit(),
      child: BlocBuilder<NavebarsdCubit, NavebarsdState>(
        builder: (context, state) {
          final indexChange = context.read<NavebarsdCubit>();
          return Scaffold(
            extendBody: true,
            body: Stack(
              children: [
                widgetChangeIndex[indexChange.courntIndex],
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomNavBar(indexChange),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavBar(NavebarsdCubit indexChange) {
    return Container(
      height: 80.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.15),
            blurRadius: 30,
            offset: Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.white.withOpacity(0.8),
            BlendMode.srcOver,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.home_rounded, 'Home', indexChange),
              _buildNavItem(1, Icons.shopify, 'Shop', indexChange),
              _buildCenterNavItem(indexChange),
              _buildNavItem(3, Icons.shopping_cart_rounded, 'Cart', indexChange),
              _buildNavItem(4, Icons.person_rounded, 'Profile', indexChange),
            ],
          ),
        ),
      ),
    );
  }

  void _animateIcon() {
    if (_isControllerInitialized && mounted) {
      try {
        _animationController.reset();
        _animationController.forward();
      } catch (e) {
        // Safely ignore animation errors
        print("Animation error: $e");
      }
    }
  }

  Widget _buildCenterNavItem(NavebarsdCubit cubit) {
    return GestureDetector(
      onTap: () {
        if (!mounted) return;
        cubit.changeCourntIndex(2);
        _animateIcon();
      },
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor,
              Color(0xFF9747FF),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: AnimatedRotation(
            turns: cubit.courntIndex == 2 ? 0.125 : 0,
            duration: Duration(milliseconds: 300),
            child: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, NavebarsdCubit cubit) {
    final isSelected = cubit.courntIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!mounted) return;
          cubit.changeCourntIndex(index);
          _animateIcon();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              height: isSelected ? 40.h : 30.h,
              width: isSelected ? 40.w : 30.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(isSelected ? 14.r : 8.r),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isSelected ? AppColors.primaryColor : AppColors.grey,
                  size: isSelected ? 26 : 22,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
