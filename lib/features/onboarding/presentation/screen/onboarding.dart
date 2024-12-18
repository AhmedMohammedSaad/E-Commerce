// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/StringImage/string_image.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              // SizedBox(
              //   height: 20.w,
              // ),
              Row(
                children: [
                  SizedBox(
                    width: 17.w,
                  ),
                  SvgPicture.asset(
                    StringImage.onbording,
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .then(delay: 200.ms) // baseline=800ms
                  .slide(),
              SizedBox(
                height: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 9.h,
                children: [
                  Text(
                    'All your shopping in one App',
                    style: StyleTextApp.font24ColorblacColor,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .then(delay: 200.ms) // baseline=800ms
                      .slide(),
                  Text(
                    'Sell your devices the smarter,\nfaster way for immediate cash and a cleaner conscience.\nSell your devices the smarter,\nfaster way for immediate cash and a cleaner conscience.',
                    style: StyleTextApp.font14Colorgrayofwite,
                  )
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottonAPP(
                      width: 140,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signIn');
                      },
                      nameBotton: 'Log In',
                      colorBotton: ColorManager.green,
                      colorText: ColorManager.white),
                  BottonAPP(
                    width: 140,
                    onTap: () {
                      // Navigator.pushReplacementNamed(context, '/signUP');
                    },
                    nameBotton: 'Log In',
                    colorBotton: ColorManager.white,
                    colorText: ColorManager.green,
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .then(delay: 200.ms) // baseline=800ms
                  .slide(),
            ],
          )),
    );
  }
}
