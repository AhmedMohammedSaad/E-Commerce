import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChackoutAndDelete extends StatelessWidget {
  const ChackoutAndDelete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        //! checkout button
        Container(
          alignment: Alignment.center,
          height: 30.h,
          width: 80.w,
          color: ColorManager.green,
          child: Text(
            "Checkout",
            style: StyleTextApp.font14ColorWhiteFontWeightBold,
          ),
        ),
        //! delete button
        Container(
          alignment: Alignment.center,
          height: 30.h,
          width: 80.w,
          color: ColorManager.red,
          child: Text(
            "Delete",
            style: StyleTextApp.font14ColorWhiteFontWeightBold,
          ),
        ),
      ],
    );
  }
}
