import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: non_constant_identifier_names
Padding SaleText(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    child: Column(spacing: 20, children: [
      Row(
        children: [
          Text(
            title,
            style: StyleTextApp.font24ColorblacColorFontWeightBolde,
          ),
        ],
      ),
    ]),
  );
}
