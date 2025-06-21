import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: non_constant_identifier_names
Stack HomWidget(BuildContext context, List<ProductsShop> getProductSale, int index) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.all(8.h),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          height: 185.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // لون أسود مع شفافية
                offset: Offset(3, 5), // اتجاه ومسافة الظل
                blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                spreadRadius: 2, // عرض الظل
                blurRadius: 11, // نعومة الظل
              ),
            ],
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            //! iamge product
            child: CachedNetworkImage(
              imageUrl: getProductSale[index].imageUrl.toString(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) {
                var card = Card(
                  child: LoadingAnimationWidget.dotsTriangle(
                    size: 80,
                    color: AppColors.primaryColor,
                  ),
                );
                return SizedBox(
                  height: 185.h,
                  width: 200.w,
                  child: card,
                );
              },
              errorWidget: (context, url, error) => const Icon(Icons.broken_image_rounded, size: 50),
            ),
          ),
        ),
      ),
      //! container Sales
      Positioned(
        top: 8.h, // المسافة من الأعلى
        right: 28.w, // المسافة من اليمين
        child: Container(
          alignment: Alignment.center,
          height: 50.h,
          width: 44.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // لون أسود مع شفافية
                offset: Offset(4, 4), // اتجاه ومسافة الظل
                blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                spreadRadius: 2, // عرض الظل
                blurRadius: 8, // نعومة الظل
              ),
            ],
            color: AppColors.primaryColor, // لون الشريط
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7.r),
              bottomRight: Radius.circular(7.r),
            ),
          ),
          //! text Sale
          child: Text(
              '${calculateSaleOffer(
                int.tryParse(getProductSale[index].price?.toString() ?? "0") ?? 0,
                int.tryParse(getProductSale[index].oldPrice?.toString() ?? "0") ?? 0,
              )}% OFF',
              style: StyleTextApp.font14ColorWhiteFontWeightBold),
        ),
      ),
      //! the container is Opacity
      Positioned(
        bottom: 8.h,
        left: 16.w,
        child: Container(
          alignment: Alignment.center,
          height: 40.h,
          width: MediaQuery.of(context).size.width * 0.91,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: AppColors.black.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14.r),
              bottomRight: Radius.circular(14.r),
            ),
          ),
          //! text title
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.86,
            child: Text(
              textAlign: TextAlign.center,
              getProductSale[index].productName.toString(),
              style: StyleTextApp.font14ColorWhiteFontWeightBold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    ],
  );
}

//! function calculate Sale Offer
int calculateSaleOffer(int price, int oldPrice) {
  // Check if prices are valid
  if (oldPrice <= 0 || price <= 0) {
    return 0; // Return 0% discount instead of throwing error
  }

  // Ensure old price is greater than current price
  if (price >= oldPrice) {
    return 0; // No discount if current price is higher than old price
  }

  double discountPercentage = ((oldPrice - price) / oldPrice) * 100;
  return discountPercentage.toInt();
}
