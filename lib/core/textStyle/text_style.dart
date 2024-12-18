// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! the class he is text syle in app
class StyleTextApp {
  //!
  static final font10ColorMainColor = TextStyle(
    color: const Color.fromARGB(255, 44, 43, 43),
    fontSize: 10.sp,
  );
  static final font12ColorMainColor = TextStyle(
    color: ColorManager.grey,
    fontSize: 12.sp,
  );
  //!
  static final font14ColorMainColor = TextStyle(
    color: const Color.fromARGB(255, 180, 180, 178),
    fontSize: 14.sp,
  );
  //!
  static final font20ColorblacColor = TextStyle(
    color: const Color.fromARGB(255, 0, 0, 0),
    fontSize: 20.sp,
  );

  static final font20ColorManColor = TextStyle(
    color: ColorManager.green,
    fontSize: 20.sp,
  );
}
