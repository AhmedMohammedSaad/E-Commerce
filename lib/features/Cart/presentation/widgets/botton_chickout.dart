import 'dart:developer';

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:advanced_app/features/Cart/presentation/pages/detalles_chackout.dart';
import 'package:advanced_app/core/widgets/botton.dart';

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
    return BottonAPP(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              color: ColorManager.white,
              child: Column(
                spacing: 20.h,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "طرق الدفع",
                    style: StyleTextApp.font24ColorblacColorFontWeightBolde,
                  ),
                  BottonAPP(
                    onTap: () {
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
                    nameBotton: "عند التوصيل ",
                    colorBotton: ColorManager.green,
                    colorText: ColorManager.white,
                    width: 250.w,
                  ),
                  BottonAPP(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                            onPaymentSuccess: () {
                              // Handle payment success
                              log("Succses");
                            },
                            onPaymentError: () {
                              // Handle payment failure
                              log("Error");
                            },
                            price: totlePrice
                                .toDouble(), // Required: Total price (e.g., 100 for 100 EGP)
                          ),
                        ),
                      );
                    },
                    nameBotton: "Visa",
                    colorBotton: ColorManager.green,
                    colorText: ColorManager.white,
                    width: 250.w,
                  ),
                  //! viesa
                ],
              ),
            );
          },
        );
      },
      nameBotton: 'Checkout',
      colorBotton: ColorManager.green,
      colorText: ColorManager.white,
      width: double.infinity,
    );
  }
}
