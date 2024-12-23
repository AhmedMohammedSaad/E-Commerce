import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerReting extends StatelessWidget {
  const ContainerReting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      alignment: Alignment.center,
      height: 30.h,
      // width: 46.w,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(51, 0, 0, 0),
            spreadRadius: 2,
            offset: Offset(5, 2),
            blurRadius: 10,
          ),
        ],
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      //! this icon is star teting
      child: Row(
        children: [
          const Icon(
            Icons.star_rate_rounded,
            color: ColorManager.gold,
          ),
          //! this text is  reting
          Text(
            '12.2',
            style: StyleTextApp.font12ColorblacFontWeightBold,
          ),
        ],
      ),
    );
  }
}
