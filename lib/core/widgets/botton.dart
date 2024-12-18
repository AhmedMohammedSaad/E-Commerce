import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonAPP extends StatelessWidget {
  const BottonAPP(
      {super.key,
      required this.nameBotton,
      required this.colorBotton,
      required this.colorText,
      this.onTap,
      required this.width});
  final double width;
  final String nameBotton;
  final Color colorBotton;
  final Color colorText;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorBotton,
        ),
        child: Text(
          nameBotton,
          style: TextStyle(
            color: colorText,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
