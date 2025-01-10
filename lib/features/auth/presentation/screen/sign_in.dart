// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/functions/snack_bar_error.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:advanced_app/features/auth/presentation/widget/login_text_filed_and_button_login.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();

          if (state is LoginFailure) {
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

          return Scaffold(
            body: state is LoginLoading
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 80,
                      color: ColorManager.green,
                    ),
                  )
                : SingleChildScrollView(
                    child: Form(
                        key: _formKey,
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
                                  Text(
                                    "Sign In",
                                    style: StyleTextApp
                                        .font24ColorblacColorFontWeightBolde,
                                  ),
                                  Text(
                                    "Welcome back! Don’t have an account?",
                                    style: StyleTextApp.font14Colorblac,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/singUP',
                                      );
                                    },
                                    child: Text(
                                      "Sign UP",
                                      style: StyleTextApp.font20ColorManColor,
                                    ),
                                  ),

                                  //! Text Feild using email and password
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFieldandButtonLogin(
                                      controllerGemail: controllerGemail,
                                      controllerPassword: controllerPassword,
                                    ),
                                  ),
                                  BottonAPP(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.login(
                                          controllerGemail.text,
                                          controllerPassword.text,
                                        );
                                      }
                                    },
                                    nameBotton: 'Log In',
                                    colorBotton: ColorManager.green,
                                    colorText: ColorManager.white,
                                    width: double.infinity.w,
                                  )
                                      .animate()
                                      .then(
                                          duration: 1000.ms) // تأخير قبل العودة
                                      .fadeIn(duration: 1000.ms),
                                  //! Forgot Password ?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/forgotPass');
                                        },
                                        child: Text(
                                          "Forgot password?",
                                          style:
                                              StyleTextApp.font13ColorManColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // DividerOR(),
                                  // LoginWhitheGoogleandFaceBook(
                                  //     onTap: () => cubit.signInWithFacebook()),
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
