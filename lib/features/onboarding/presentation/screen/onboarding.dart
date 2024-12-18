// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/StringImage/string_image.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 10.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(StringImage.onbording),
          Text(
            'All your shopping in one App',
            style: StyleTextApp.font20ColorblacColor,
          ),
          Text(
            'Sell your devices the smarter,\nfaster way for immediate cash and a cleaner conscience.\nSell your devices the smarter,\nfaster way for immediate cash and a cleaner conscience.',
            style: StyleTextApp.font10ColorMainColor,
          ),
        ],
      ),
    );
  }
}
