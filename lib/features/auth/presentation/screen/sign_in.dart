// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/auth/presentation/widget/divider.dart';
import 'package:advanced_app/features/auth/presentation/widget/login_whithe_google_and_faceBoock.dart';

import 'package:advanced_app/features/auth/presentation/widget/text_filed_and_button_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController controllerGemail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: ColorManager.green,
            width: double.infinity,
            height: 108.h,
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
                  style: StyleTextApp.font24ColorblacColorFontWeightBolde,
                ),
                Text(
                  "Welcome back! Don’t have an account?",
                  style: StyleTextApp.font14Colorblac,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Sign UP",
                    style: StyleTextApp.font20ColorManColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldandButtonLogin(
                      controllerGemail: controllerGemail,
                      controllerPassword: controllerPassword),
                ),
                DividerOR(),
                LoginWhitheGoogleandFaceBook(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
