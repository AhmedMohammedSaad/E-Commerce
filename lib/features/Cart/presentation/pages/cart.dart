import 'dart:developer';

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/apikey.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/cart_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    PaymentData.initialize(
      apiKey:
          apiKeyForBayMob, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
          integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID

      // Optional User Data
      // userData: UserData(
      //   email: "User Email", // Optional: Defaults to 'NA'
      //   phone: "User Phone", // Optional: Defaults to 'NA'
      //   name: "User First Name", // Optional: Defaults to 'NA'
      //   lastName: "User Last Name", // Optional: Defaults to 'NA'
      // ),

      // Optional Style Customizations
      style: Style(
        primaryColor: ColorManager.green, // Default: Colors.blue
        scaffoldColor: Colors.white, // Default: Colors.white
        appBarBackgroundColor: ColorManager.green, // Default: Colors.blue
        appBarForegroundColor: Colors.white, // Default: Colors.white
        textStyle: const TextStyle(), // Default: TextStyle()
        buttonStyle:
            ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
        circleProgressColor: ColorManager.green, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
    super.initState();
  }

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
                                nameBotton: 'Checkout',
                                colorBotton: ColorManager.green,
                                colorText: ColorManager.white,
                                width: double.infinity,
                              ),
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
        }),
      ),
    );
  }
}
