import 'package:advanced_app/core/api/dio_consumer.dart';

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/botton_chickout.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/cart_category.dart';
import 'package:advanced_app/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: appBar(leding: false, title: 'My Cart'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartCubit(apiConsumer: DioConsumer())..getCart(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(apiConsumer: DioConsumer())..getDataUser(),
          ),
        ],
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            // Get cart list from cubit
            List<CartModel> cartsList = context.read<CartCubit>().carts;

            // Calculate total from cubit with quantities
            final totalPrice = context.read<CartCubit>().calculateTotalPrice();

            if (state is GetCartLoding) {
              return const LodingAppList();
            }

            if (cartsList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80.sp,
                      color: AppColors.primaryColor.withOpacity(0.5),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Your cart is empty",
                      style: StyleTextApp.font16ColorblacFontWeightBold,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Add items to get started",
                      style: StyleTextApp.font14Colorgrayofwite,
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 10.h),
                          child: Text(
                            "Products (${cartsList.length})",
                            style: StyleTextApp.font14ColorblacFontWeightBold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cartsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardCategory(
                                cartModel: cartsList[index],
                                carts: cartsList,
                                index: index,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, -3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: StyleTextApp.font14Colorgrayofwite,
                            ),
                            Text(
                              "${totalPrice.toStringAsFixed(0)} LE",
                              style: StyleTextApp.font14ColorblacFontWeightBold,
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery",
                              style: StyleTextApp.font14Colorgrayofwite,
                            ),
                            Text(
                              "Free",
                              style: StyleTextApp.font13ColorManColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        const Divider(),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: StyleTextApp.font16ColorblacFontWeightBold,
                            ),
                            Text(
                              "${totalPrice.toStringAsFixed(0)} LE",
                              style: StyleTextApp.font16ColorblacFontWeightBold.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        BottonCheckout(
                          cartsList: cartsList,
                          totlePrice: totalPrice.toInt(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
