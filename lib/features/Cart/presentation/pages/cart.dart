import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/cart_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      body: BlocProvider(
        create: (context) => CartCubit(apiConsumer: DioConsumer())..getCart(),
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          //! totale price

          int totlePrice = 0;
          List<CartModel> cartsList = context.read<CartCubit>().carts;
          for (int x = 0; x < cartsList.length; x++) {
            totlePrice += int.parse(cartsList[x].products!.price.toString());
          }

          return state is GetCartLoding
              ? const LodingApp()
              : Column(
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
                      )
                          .animate()
                          // .fadeIn(duration: 600.ms)
                          .then(delay: 200.ms)
                          .slide(
                            begin:
                                const Offset(1.1, 1.1), // Start from the right
                            end: Offset.zero, // End at the original position
                            duration: 300.ms,
                          ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(
                                47, 0, 0, 0), // لون أسود مع شفافية
                            offset: Offset(-10, -13), // اتجاه ومسافة الظل
                            blurStyle:
                                BlurStyle.normal, // تأثير طبيعي على الحواف
                            spreadRadius: 1, // عرض الظل
                            blurRadius: 7, // نعومة الظل
                          ),
                        ],
                        color: ColorManager.white,
                      ),
                      padding: EdgeInsets.all(20.h),
                      height: 140.h,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style:
                                    StyleTextApp.font14ColorblacFontWeightBold,
                              ),
                              Text(
                                "$totlePrice LE",
                                style:
                                    StyleTextApp.font16ColorblacFontWeightBold,
                              ),
                            ],
                          ),
                          const Divider(),
                          const Spacer(),
                          const BottonAPP(
                            nameBotton: 'Checkout',
                            colorBotton: ColorManager.green,
                            colorText: ColorManager.white,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}
