// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonReviews extends StatelessWidget {
  const BottonReviews({
    super.key,
    required this.onPressedToCart,
  });
  final Function() onPressedToCart;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
                width: MediaQuery.of(context).size.width / 1,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // لون الظل
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: BottonAPP(
                  onTap: onPressedToCart,
                  nameBotton: 'ADD TO CART',
                  colorBotton: ColorManager.green,
                  colorText: ColorManager.white,
                  width: MediaQuery.of(context).size.width / 1,
                ))
            .animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(
              delay: 20.ms,
              duration: 600.ms,
            ),
      ],
    );
  }
}
