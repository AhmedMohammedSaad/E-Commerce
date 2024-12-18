// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:advanced_app/features/auth/presentation/widget/divider.dart';
import 'package:advanced_app/features/auth/presentation/widget/login_whithe_google_and_faceBoock.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingUP extends StatefulWidget {
  const SingUP({super.key});

  @override
  State<SingUP> createState() => _SingUPState();
}

class _SingUPState extends State<SingUP> {
  final TextEditingController controllerGemail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    "Sing UP",
                    style: StyleTextApp.font24ColorblacColorFontWeightBolde,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 15.h,
                      children: [
                        TextFiealdApp(
                          controller: controllerName,
                          hintText: 'Name',
                        ),
                        TextFiealdApp(
                          controller: controllerGemail,
                          hintText: 'Gmail',
                        ),
                        TextFiealdPassword(
                          controller: controllerPassword,
                          hintText: 'Password',
                        ),
                        BottonAPP(
                          onTap: () {},
                          nameBotton: 'Log In',
                          colorBotton: ColorManager.green,
                          colorText: ColorManager.white,
                          width: double.infinity.w,
                        ),
                      ],
                    ),
                  ),
                  DividerOR(),
                  LoginWhitheGoogleandFaceBook(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
