import 'package:advanced_app/core/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonDelete extends StatelessWidget {
  const ButtonDelete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      // alignment: Alignment.center,
      // height: 30.h,
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
        color: const Color.fromARGB(170, 255, 255, 255),
        borderRadius: BorderRadius.circular(14.r),
      ),
      //!delete button
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete_forever,
            color: ColorManager.red,
          )),
    );
  }
}
