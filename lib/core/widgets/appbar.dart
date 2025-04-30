import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

AppBar appBar({
  required bool leding,
  required String title,
}) {
  return AppBar(
    automaticallyImplyLeading: leding,

    // leading: const Icon(Icons.arrow_back_ios_new_rounded),
    // title: Text(
    //   "Code Shop",
    //   style: StyleTextApp.font14ColorblacFontWeightBold.copyWith(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 20.sp,
    //   ),
    // ),
    title: Image(
      width: 40.w,
      image: const AssetImage(
        'assets/images/code_shop_logo.jpeg',
      ),
    ),
  );
}
