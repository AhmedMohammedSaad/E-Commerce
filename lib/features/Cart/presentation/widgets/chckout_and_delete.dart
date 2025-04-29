import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      return InkWell(
        onTap: () {
          context
              .read<CartCubit>()
              .deleteCart(product[index].products!.productId.toString());
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          alignment: Alignment.center,
          height: 30.h,
          width: 167.w,
          child: Text(
            "Delete",
            style: StyleTextApp.font14ColorWhiteFontWeightBold,
          ),
        ),
      );
    });
  }
}
