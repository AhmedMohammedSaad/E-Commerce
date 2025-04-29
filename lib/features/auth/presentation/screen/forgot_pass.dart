// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/functions/snack_bar_error.dart';
import 'package:advanced_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Purple theme colors
  final Color primaryPurple = AppColors.primaryColor;
  final Color lightPurple = AppColors.primaryColor.withOpacity(0.2);
  final Color accentPurple = const Color.fromARGB(255, 194, 190, 231);
  final Color backgroundPurple = const Color.fromARGB(255, 203, 204, 230);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        if (state is ResetPasswordFailure) {
          Future.microtask(() {
            snackBarError(context, state.error);
          });
        } else if (state is ResetPasswordSuccess) {
          Future.microtask(() {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Reset link sent to your email'),
                backgroundColor: primaryPurple,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          });
        }
        return Scaffold(
          backgroundColor: backgroundPurple,
          body: state is ResetPasswordLoading
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
                      children: [
                        // Purple curved header
                        Container(
                          width: double.infinity,
                          height: 180.h,
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
                                  Icons.lock_reset_outlined,
                                  size: 60.sp,
                                  color: Colors.white,
                                ).animate().fadeIn(duration: 600.ms),
                                SizedBox(height: 10.h),
                                Text(
                                  "Reset Password",
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
                              horizontal: 25.w, vertical: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                  color: primaryPurple,
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 200.ms)
                                  .moveY(begin: 20, end: 0),

                              SizedBox(height: 15.h),

                              Text(
                                "Enter your email address and we'll send you a link to reset your password.",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey[700],
                                ),
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
                                  controller: controller,
                                  keyboardType: TextInputType.emailAddress,
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
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: BorderSide(
                                          color: primaryPurple, width: 1.5),
                                    ),
                                  ),
                                ),
                              ).animate().fadeIn(delay: 600.ms),

                              SizedBox(height: 30.h),

                              // Reset Button
                              Container(
                                width: double.infinity,
                                height: 55.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      cubit.resetPassword(controller.text);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    "SEND RESET LINK",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 800.ms)
                                  .moveY(begin: 20, end: 0),

                              SizedBox(height: 20.h),

                              // Return to Sign In button
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Back to Sign In",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: primaryPurple,
                                    ),
                                  ),
                                ),
                              ).animate().fadeIn(delay: 1000.ms),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
