import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/botton_reviews.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Container addToCartBottn(
  BuildContext context,
  productID,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 112.h,
    color: Colors.white,
    child: BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return state is GetCartLoding
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 60,
                      color: AppColors.primaryColor,
                    ),
                  )
                : BottonReviews(
                    onPressedToCart: () {
                      final carts = context.read<CartCubit>().carts;

                      // التحقق من وجود المنتج في السلة
                      final isProductInCart = carts.any(
                        (cart) => cart.products!.productId == productID.productId,
                      );

                      if (isProductInCart) {
                        // إذا كان المنتج موجودًا في السلة، عرض رسالة
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Text(
                                "تمت الإضافة إلى السلة مسبقًا",
                                style: StyleTextApp.font14ColorWhiteFontWeightBold,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      } else {
                        // إذا لم يكن المنتج موجودًا في السلة، إضافته
                        context.read<ShopCubit>().addToCart(
                              productID.productId.toString(),
                            );

                        // عرض رسالة نجاح
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Text(
                                "تمت الإضافة إلى السلة بنجاح",
                                style: StyleTextApp.font14ColorWhiteFontWeightBold,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      }
                      context.read<CartCubit>().getCart();
                    },
                  );
          },
        );
      },
    ),
  );
}
