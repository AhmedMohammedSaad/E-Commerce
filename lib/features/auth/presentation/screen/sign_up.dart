// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/functions/snack_bar_error.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:advanced_app/features/auth/presentation/screen/sign_in.dart';
import 'package:advanced_app/features/auth/presentation/widget/divider.dart';

import 'package:advanced_app/features/auth/presentation/widget/signup_text_filed_and_button.dart';
import 'package:advanced_app/features/auth/presentation/widget/signup_whithe_google_and_faceboock.dart';
import 'package:advanced_app/features/nav_bar/page/nav_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is SignUpFailure) {
            Future.microtask(() {
              snackBarError(context, state.error);
            });
          }

          final cubit = context.read<AuthCubit>();
          if (state is SignInWithGoogleLoading) {
            Future.microtask(() {
              LoadingAnimationWidget.dotsTriangle(
                size: 80,
                color: ColorManager.green,
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
            body: state is SignUpLoading
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 80,
                      color: ColorManager.green,
                    ),
                  )
                : SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: ColorManager.green,
                            width: double.infinity,
                            height: 130.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10.h,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sing UP",
                                      style: StyleTextApp
                                          .font24ColorblacColorFontWeightBolde,
                                    ),
                                    //! text button skip
                                    // TextButton(
                                    //   onPressed: () {
                                    //     Navigator.pushNamedAndRemoveUntil(
                                    //       context,
                                    //       '/navBar',
                                    //       (route) => false,
                                    //     );
                                    //   },
                                    //   child: Text(
                                    //     "Skip",
                                    //     style: StyleTextApp.font20ColorManColor,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Text(
                                  "Welcome back! Your create an account?",
                                  style: StyleTextApp.font14Colorblac,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/signIn',
                                    );
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: StyleTextApp.font20ColorManColor,
                                  ),
                                ),
                                //! Text Feild using name and email and password
                                TextFieldandButtonSignup(
                                  controllerName: controllerName,
                                  controllerGemail: controllerGemail,
                                  controllerPassword: controllerPassword,
                                ),
                                // DividerOR(),
                                // SingUPWhitheGoogleandFaceBook(),
                                BottonAPP(
                                  onTap: () {
                                    if (_key.currentState!.validate()) {
                                      cubit.signup(
                                        controllerName.text,
                                        controllerGemail.text,
                                        controllerPassword.text,
                                      );
                                    }
                                  },
                                  nameBotton: 'Sign UP',
                                  colorBotton: ColorManager.green,
                                  colorText: ColorManager.white,
                                  width: double.infinity.w,
                                )
                                    .animate()
                                    .then(duration: 1000.ms) // تأخير قبل العودة
                                    .fadeIn(
                                        duration: 1000.ms), // الظهور التدريجي
                                DividerOR(),
                                SingUPWhitheGoogleandFaceBook(
                                  onTap: () => cubit.nativeGoogleSignIn(),
                                ),
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
