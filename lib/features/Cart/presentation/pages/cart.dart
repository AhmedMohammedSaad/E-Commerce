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
      //! AppBar
      appBar: appBar(leding: false, title: 'Cart'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CartCubit(apiConsumer: DioConsumer())..getCart(),
          ),
          BlocProvider(
            create: (context) =>
                ProfileCubit(apiConsumer: DioConsumer())..getDataUser(),
          ),
        ],
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            //! totale price

            int totlePrice = 0;
            //!list of carts
            List<CartModel> cartsList = context.read<CartCubit>().carts;
            for (int x = 0; x < cartsList.length; x++) {
              totlePrice += int.parse(cartsList[x].products!.price.toString());
            }

            return state is GetCartLoding
                ? const LodingAppList()
                : cartsList.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cartsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              //! this container is for widget image and shop ....
                              return CardCategory(
                                cartModel: cartsList[index],
                                carts: cartsList,
                                index: index,
                              );
                            },
                          )),
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(
                                      47, 0, 0, 0), // لون أسود مع شفافية
                                  offset: Offset(-10, -13), // اتجاه ومسافة الظل
                                  blurStyle: BlurStyle
                                      .normal, // تأثير طبيعي على الحواف
                                  spreadRadius: 1, // عرض الظل
                                  blurRadius: 7, // نعومة الظل
                                ),
                              ],
                              color: AppColors.white,
                            ),
                            padding: EdgeInsets.all(20.h),
                            height: 140.h,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: StyleTextApp
                                          .font14ColorblacFontWeightBold,
                                    ),
                                    Text(
                                      "$totlePrice LE",
                                      style: StyleTextApp
                                          .font16ColorblacFontWeightBold,
                                    ),
                                  ],
                                ),
                                const Divider(),
                                const Spacer(),
                                BottonCheckout(
                                    cartsList: cartsList,
                                    totlePrice: totlePrice),
                              ],
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Text(
                          "No Cart",
                          style: StyleTextApp.font14ColorblacFontWeightBold,
                        ),
                      );
          },
        ),
      ),
    );
  }
}
