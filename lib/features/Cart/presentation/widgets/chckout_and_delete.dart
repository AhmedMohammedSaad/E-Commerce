import 'dart:developer';

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class ChackoutAndDelete extends StatelessWidget {
  const ChackoutAndDelete({
    super.key,
    required this.product,
    required this.index,
  });
  final List<CartModel> product;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        //! checkout button
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return InkWell(
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
                        price: double.parse(
                            product[index].products!.price.toString())
                        // Required: Total price (e.g., 100 for 100 EGP)
                        ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 30.h,
                width: 80.w,
                color: ColorManager.green,
                child: Text(
                  "Checkout",
                  style: StyleTextApp.font14ColorWhiteFontWeightBold,
                ),
              ),
            );
          },
        ),
        //! delete button
        BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          return InkWell(
            onTap: () {
              context
                  .read<CartCubit>()
                  .deleteCart(product[index].products!.productId.toString());
            },
            child: Container(
              alignment: Alignment.center,
              height: 30.h,
              width: 80.w,
              color: ColorManager.red,
              child: Text(
                "Delete",
                style: StyleTextApp.font14ColorWhiteFontWeightBold,
              ),
            ),
          );
        }),
      ],
    );
  }
}
