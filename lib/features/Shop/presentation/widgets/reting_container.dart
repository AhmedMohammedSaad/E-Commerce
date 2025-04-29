import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerReting extends StatelessWidget {
  const ContainerReting({
    super.key,
    required this.getProductData,
    required this.index,
  });
  final int index;
  final List<ProductsShop> getProductData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      alignment: Alignment.center,
      height: 30.h,
      //  width: 46.w,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(51, 0, 0, 0),
            spreadRadius: 2,
            offset: Offset(5, 2),
            blurRadius: 10,
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      //! this icon is star teting
      child: Row(
        children: [
          const Icon(
            Icons.star_rate_rounded,
            color: AppColors.gold,
          ),
          //! this text is  reting
          Text(
            getProductData[index].rating != null &&
                    getProductData[index].rating!.isNotEmpty
                ? getProductData[index].rating![0].ratingNum.toString()
                : "0",
            style: StyleTextApp.font12ColorblacFontWeightBold,
          ),
        ],
      ),
    );
  }
}
