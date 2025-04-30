// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/functions/snack_bar_error.dart';
import 'package:advanced_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:advanced_app/features/auth/presentation/screen/sign_in.dart';

import 'package:advanced_app/features/nav_bar/page/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class SingUP extends StatefulWidget {
  const SingUP({super.key});

  @override
  State<SingUP> createState() => _SingUPState();
}

class _SingUPState extends State<SingUP> {
  final TextEditingController controllerGemail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Purple theme colors
  final Color primaryPurple = AppColors.primaryColor;
  final Color lightPurple = AppColors.primaryColor.withOpacity(0.2);
  final Color accentPurple = const Color.fromARGB(255, 194, 190, 231);
  final Color backgroundPurple = const Color.fromARGB(255, 231, 229, 245);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is SignUpFailure) {
            Future.microtask(() {
              // ignore: use_build_context_synchronously
              snackBarError(context, state.error);
            });
          }

          final cubit = context.read<AuthCubit>();
          if (state is SignInWithGoogleLoading) {
            Future.microtask(() {
              LoadingAnimationWidget.dotsTriangle(
                size: 80,
                color: primaryPurple,
              );
            });
          }
          if (state is SignInWithGoogleFailure) {
            // ignore: use_build_context_synchronously
            Future.microtask(() => snackBarError(context, state.error));
          } else if (state is SignInWithGoogleSuccess) {
            Future.microtask(() async {
              await Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (ctx) => NavBar()),
                (route) => false,
              );
            });
          }
          if (state is SignUpSuccess) {
            Future.microtask(() async {
              await Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (ctx) => SignIn()),
                (route) => false,
              );
            });
          }
          return Scaffold(
            backgroundColor: backgroundPurple,
            body: state is SignUpLoading
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 80,
                      color: primaryPurple,
                    ),
                  )
                : SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Purple curved header
                          Container(
                            width: double.infinity,
                            height: 200.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [primaryPurple, lightPurple],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40.r),
                                bottomRight: Radius.circular(40.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_add_outlined,
                                    size: 60.sp,
                                    color: Colors.white,
                                  ).animate().fadeIn(duration: 600.ms),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "create_account".tr(),
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ).animate().fadeIn(duration: 800.ms),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "sign_up".tr(),
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.bold,
                                    color: primaryPurple,
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 200.ms)
                                    .moveY(begin: 20, end: 0),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Text(
                                      "already_have_account".tr(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/signIn',
                                        );
                                      },
                                      child: Text(
                                        "sign_in".tr(),
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: primaryPurple,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).animate().fadeIn(delay: 400.ms),
                                SizedBox(height: 30.h),

                                // Name Field
                                Container(
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
                                  child: TextFormField(
                                    controller: controllerName,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "please_enter_name".tr();
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "full_name".tr(),
                                      prefixIcon: Icon(Icons.person_outline,
                                          color: primaryPurple),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide: BorderSide(
                                            color: primaryPurple, width: 1.5),
                                      ),
                                    ),
                                  ),
                                ).animate().fadeIn(delay: 600.ms),
                                SizedBox(height: 15.h),

                                // Email Field
                                Container(
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
                                  child: TextFormField(
                                    controller: controllerGemail,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "please_enter_email".tr();
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "email".tr(),
                                      prefixIcon: Icon(Icons.email_outlined,
                                          color: primaryPurple),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide: BorderSide(
                                            color: primaryPurple, width: 1.5),
                                      ),
                                    ),
                                  ),
                                ).animate().fadeIn(delay: 800.ms),
                                SizedBox(height: 15.h),

                                // Password Field
                                Container(
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
                                  child: TextFormField(
                                    controller: controllerPassword,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "please_enter_password".tr();
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "password".tr(),
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: primaryPurple),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        borderSide: BorderSide(
                                            color: primaryPurple, width: 1.5),
                                      ),
                                    ),
                                  ),
                                ).animate().fadeIn(delay: 1000.ms),
                                SizedBox(height: 25.h),

                                // Sign Up Button
                                Container(
                                  width: double.infinity,
                                  height: 55.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_key.currentState!.validate()) {
                                        cubit.signup(
                                          controllerName.text,
                                          controllerGemail.text,
                                          controllerPassword.text,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: Text(
                                      "signup_button".tr(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 1200.ms)
                                    .moveY(begin: 20, end: 0),

                                SizedBox(height: 25.h),

                                // OR divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Text(
                                        "or".tr(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ).animate().fadeIn(delay: 1400.ms),

                                SizedBox(height: 25.h),

                                // Google Sign Up Button
                                Container(
                                  width: double.infinity,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    border:
                                        Border.all(color: Colors.grey[400]!),
                                    color: Colors.white,
                                  ),
                                  child: InkWell(
                                    onTap: () => cubit.nativeGoogleSignIn(),
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/googleIcon.png',
                                          width: 25.w,
                                        ),
                                        SizedBox(width: 15.w),
                                        Text(
                                          "continue_with_google".tr(),
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 1600.ms)
                                    .moveY(begin: 20, end: 0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  @override
  dispose() {
    controllerGemail.dispose();
    controllerPassword.dispose();
    controllerName.dispose();
    super.dispose();
  }
}
