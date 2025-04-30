// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';
import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Purple theme colors
    const Color primaryPurple = AppColors.primaryColor;
    final Color lightPurple = AppColors.primaryColor.withOpacity(0.2);
    const Color backgroundPurple = Color.fromARGB(255, 249, 245, 255);

    return BlocProvider(
      create: (context) =>
          ProfileCubit(apiConsumer: DioConsumer())..getDataUser(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is GetDataUserFailure) {
            log(state.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load profile: ${state.error}'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          }
          if (state is GetDataUserSuccess) {
            log("success");
          }
        },
        builder: (context, state) {
          final user = context.read<ProfileCubit>().getDataUserModel;
          final isLoading = state is GetDataUserLoading;

          return Scaffold(
            backgroundColor: backgroundPurple,
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryPurple,
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      // Custom app bar with purple gradient
                      SliverAppBar(
                        expandedHeight: 200.h,
                        pinned: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [primaryPurple, lightPurple],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.r),
                              bottomRight: Radius.circular(30.r),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: FlexibleSpaceBar(
                            title: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            centerTitle: true,
                          ),
                        ),
                      ),

                      // Profile content
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              // Profile picture with decorative ring
                              Container(
                                margin:
                                    EdgeInsets.only(top: 10.h, bottom: 20.h),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: primaryPurple,
                                    width: 4.w,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryPurple.withOpacity(0.3),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 60.r,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                    'assets/images/profileimage.png',
                                  ),
                                ),
                              )
                                  .animate()
                                  .fadeIn(duration: 600.ms)
                                  .scale(begin: const Offset(0.8, 0.8)),

                              // User name
                              Text(
                                user?.name ?? 'User Name',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: primaryPurple,
                                ),
                                textAlign: TextAlign.center,
                              )
                                  .animate()
                                  .fadeIn(delay: 200.ms)
                                  .moveY(begin: 20, end: 0),

                              SizedBox(height: 8.h),

                              // Email with icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    size: 16.sp,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    user?.email ?? 'email@example.com',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(delay: 400.ms),

                              SizedBox(height: 30.h),

                              // Profile options
                              _buildProfileOptions(context, primaryPurple),

                              SizedBox(height: 30.h),

                              // Logout button
                              Container(
                                width: double.infinity,
                                height: 55.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.red.shade700,
                                      Colors.red.shade400,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: () => _handleLogout(context),
                                  icon: Icon(
                                    Icons.logout_rounded,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'LOGOUT',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  ),
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 1000.ms)
                                  .moveY(begin: 20, end: 0),
                              SizedBox(height: 100.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context, Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildProfileOption(
            icon: Icons.history,
            title: 'Order History',
            onTap: () {},
            color: primaryColor,
            delay: 500,
          ),
          Divider(height: 1),
          _buildProfileOption(
            icon: Icons.dashboard_rounded,
            title: 'Dashboard',
            onTap: () => Navigator.pushNamed(context, '/dashboard'),
            color: primaryColor,
            delay: 600,
          ),
          Divider(height: 1),
          _buildProfileOption(
            icon: Icons.favorite_outline,
            title: 'My Favorites',
            onTap: () {},
            color: primaryColor,
            delay: 700,
          ),
          Divider(height: 1),
          _buildProfileOption(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {},
            color: primaryColor,
            delay: 800,
          ),
          Divider(height: 1),
          _buildProfileOption(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
            color: primaryColor,
            delay: 900,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0);
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
    required int delay,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          color: color,
          size: 24.sp,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.sp,
        color: Colors.grey,
      ),
      onTap: onTap,
    ).animate().fadeIn(delay: delay.ms);
  }

  Future<void> _handleLogout(BuildContext context) async {
    // Show confirmation dialog
    final bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;

    if (confirm) {
      // Clear preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Clear cart and favorites
      context.read<ProfileCubit>().deleteAllCart();
      context.read<ProfileCubit>().deleteAllFavorite();

      // Sign out from Supabase
      final supabase = Supabase.instance.client;
      await supabase.auth.signOut();

      // Navigate to sign in
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/signIn',
        (route) => false,
      );
    }
  }
}
