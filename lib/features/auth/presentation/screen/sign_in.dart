// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/functions/snack_bar_error.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:advanced_app/features/auth/presentation/widget/divider.dart';
import 'package:advanced_app/features/auth/presentation/widget/login_text_filed_and_button_login.dart';
import 'package:advanced_app/features/auth/presentation/widget/login_whithe_google_and_faceboock.dart';
import 'package:advanced_app/features/nav_bar/page/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController controllerGemail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Purple theme colors
  final Color primaryPurple = AppColors.primaryColor;
  final Color lightPurple = AppColors.primaryColor.withOpacity(0.2);
  final Color accentPurple = const Color.fromARGB(255, 162, 156, 220);
  final Color backgroundPurple = const Color.fromARGB(255, 225, 224, 249);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          if (state is LoginFailure) {
            // ignore: use_build_context_synchronously
            Future.microtask(() => snackBarError(context, state.error));
          } else if (state is LoginSuccess) {
            Future.microtask(() async {
              await Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (ctx) => NavBar()),
                (route) => false,
              );
            });
          }
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
          return Scaffold(
            backgroundColor: backgroundPurple,
            body: state is LoginLoading
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 80,
                      color: primaryPurple,
                    ),
                  )
                : SingleChildScrollView(
                    child: Form(
                        key: _formKey,
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
                                      Icons.lock_outline,
                                      size: 60.sp,
                                      color: Colors.white,
                                    ).animate().fadeIn(duration: 600.ms),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Welcome Back",
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
                                    "Sign In",
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
                                        "Don't have an account? ",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/singUP',
                                          );
                                        },
                                        child: Text(
                                          "Sign Up",
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
                                          return "Please enter your email";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Email",
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
                                  ).animate().fadeIn(delay: 600.ms),
                                  SizedBox(height: 20.h),

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
                                          return "Please enter your password";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Password",
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
                                  ).animate().fadeIn(delay: 800.ms),

                                  // Forgot password
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/forgotPass');
                                      },
                                      child: Text(
                                        "Forgot password?",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: primaryPurple,
                                        ),
                                      ),
                                    ),
                                  ).animate().fadeIn(delay: 1000.ms),

                                  SizedBox(height: 20.h),

                                  // Login Button
                                  Container(
                                    width: double.infinity,
                                    height: 55.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.login(
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
                                        "LOGIN",
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
                                          "OR",
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

                                  // Google Sign In Button
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
                                            "Continue with Google",
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
                        )),
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controllerGemail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }
}
