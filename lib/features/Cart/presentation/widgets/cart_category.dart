import 'package:advanced_app/core/apikey.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/chckout_and_delete.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/counter_add_and_remove.dart';
import 'package:advanced_app/features/Profile/data/models/get_data_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class CardCategory extends StatefulWidget {
  const CardCategory({
    super.key,
    required this.cartModel,
    required this.carts,
    required this.index,
  });

  final CartModel cartModel;
  final List<CartModel> carts;
  final int index;

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  GetDataUser? userData;
  @override
  void initState() {
    PaymentData.initialize(
      apiKey: apiKeyForBayMob,
      iframeId: iframeId,
      integrationCardId: integrationCardId,
      integrationMobileWalletId: integrationMobileWalletId,
      userData: UserData(
        email: userData?.email ?? "aaaaa",
        name: userData?.name ?? "aaaaa",
      ),
      style: Style(
        primaryColor: AppColors.primaryColor,
        scaffoldColor: AppColors.white,
        appBarBackgroundColor: AppColors.primaryColor,
        appBarForegroundColor: AppColors.white,
        textStyle: const TextStyle(),
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
        ),
        circleProgressColor: AppColors.primaryColor,
        unselectedColor: AppColors.primaryColor,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Row(
          children: [
            Container(
              width: 110.w,
              height: 120.h,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.cartModel.products!.imageUrl.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    size: 40,
                    color: AppColors.primaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.cartModel.products!.productName.toString(),
                            style: StyleTextApp.font14ColorblacFontWeightBold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // CunterAddandRemove(
                    //   price: widget.cartModel,
                    // ),
                    Row(
                      children: [
                        SizedBox(width: 12.w),
                        Text(
                          "${int.parse(widget.cartModel.products!.price.toString())} LE",
                          style: StyleTextApp.font14ColorblacFontWeightBold.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const Spacer(),
                        ChackoutAndDelete(
                          product: widget.carts,
                          index: widget.index,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
