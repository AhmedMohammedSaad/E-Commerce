// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! the class he is text syle in app
class StyleTextApp {
  //!
  static final font10Colorblack = TextStyle(
    color: ColorManager.black,
    fontSize: 10.sp,
  );
  //!
  static final font12Colorgray = TextStyle(
    color: ColorManager.grey,
    fontSize: 12.sp,
  );
  //!
  static final font14Colorgrayofwite = TextStyle(
    color: const Color.fromARGB(255, 180, 180, 178),
    fontSize: 14.sp,
  );
  //!
  static final font14Colorblac = TextStyle(
    color: ColorManager.black,
    fontSize: 14.sp,
  );
  //!
  static final font24ColorblacColor = TextStyle(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontSize: 24.sp,
  );
//!
  static final font20ColorManColor = TextStyle(
    color: ColorManager.green,
    fontSize: 20.sp,
  );
  static final font13ColorManColor = TextStyle(
    color: ColorManager.green,
    fontSize: 13.sp,
  );
  //!
  static final font24ColorblacColorFontWeightBolde = TextStyle(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static final font22ColorblacColorFontWeightBolde = TextStyle(
    color: ColorManager.blue,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
}
