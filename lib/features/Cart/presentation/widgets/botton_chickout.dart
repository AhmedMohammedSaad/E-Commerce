import 'dart:developer';

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:advanced_app/features/Cart/presentation/pages/detalles_chackout.dart';

class BottonCheckout extends StatelessWidget {
  const BottonCheckout({
    super.key,
    required this.cartsList,
    required this.totlePrice,
  });

  final List<CartModel> cartsList;
  final int totlePrice;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              padding: EdgeInsets.all(20.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Text(
                    "Payment Methods",
                    style: StyleTextApp.font16ColorblacFontWeightBold,
                  ),
                  SizedBox(height: 24.h),
                  _buildPaymentOption(
                    context: context,
                    icon: Icons.local_shipping_outlined,
                    title: "Cash on Delivery",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => DetallesCheckout(
                            productDetalse: cartsList,
                            totleProduct: totlePrice.toDouble(),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildPaymentOption(
                    context: context,
                    icon: Icons.credit_card,
                    title: "Credit/Debit Card",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                            onPaymentSuccess: () {
                              log("Success");
                            },
                            onPaymentError: () {
                              log("Error");
                            },
                            price: totlePrice.toDouble(),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Proceed to Checkout',
            style: StyleTextApp.font14ColorWhiteFontWeightBold,
          ),
          SizedBox(width: 8.w),
          Icon(Icons.arrow_forward_rounded, size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: StyleTextApp.font14ColorblacFontWeightBold,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
