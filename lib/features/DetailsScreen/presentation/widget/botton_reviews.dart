// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class BottonReviews extends StatelessWidget {
  const BottonReviews({
    super.key,
    required this.onPressedToCart,
  });
  final Function() onPressedToCart;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: BottonAPP(
        onTap: onPressedToCart,
        nameBotton: 'add_to_cart'.tr(),
        colorBotton: AppColors.primaryColor,
        colorText: AppColors.white,
        width: MediaQuery.of(context).size.width - 40.w,
      ),
    )
        .animate()
        .fadeIn()
        .scale(
          begin: Offset(0.95, 0.95),
          end: Offset(1.0, 1.0),
        )
        .move(
          delay: 20.ms,
          duration: 600.ms,
        );
  }
}
