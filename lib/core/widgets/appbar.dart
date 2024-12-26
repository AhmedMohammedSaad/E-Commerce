import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar appBar({
  required bool leding,
  required String title,
}) {
  return AppBar(
    automaticallyImplyLeading: leding,
    // leading: const Icon(Icons.arrow_back_ios_new_rounded),
    title: Text(
      title,
      style: StyleTextApp.font14ColorblacFontWeightBold,
    ),
    actions: [
      Image(
          width: 140.w,
          image: const AssetImage(
            'assets/images/logo png.png',
          ))
    ],
  );
}
