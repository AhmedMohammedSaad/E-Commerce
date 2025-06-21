// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetallesCheckout extends StatefulWidget {
  const DetallesCheckout({super.key, required this.productDetalse, required this.totleProduct});
  final List<CartModel> productDetalse;
  final double totleProduct;
  @override
  _DetallesCheckoutState createState() => _DetallesCheckoutState();
}

class _DetallesCheckoutState extends State<DetallesCheckout> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController addDetalse = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(apiConsumer: DioConsumer()),
      child: Scaffold(
        appBar: appBar(leding: true, title: 'Detalles Checkout'),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 20.h,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  TextFiealdApp(
                    controller: name,
                    hintText: 'الاسم',
                  ),
                  TextFiealdApp(
                    controller: phone,
                    hintText: 'رقم التليفون',
                  ),
                  TextFiealdApp(
                    controller: address,
                    hintText: 'العنوان',
                  ),
                  TextFiealdApp(
                    controller: addDetalse,
                    hintText: "تفاصيل اضافية للمنتج",
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is PostProductToDataBaseSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Text(
                                "تمت العملية بنجاح",
                                style: StyleTextApp.font14ColorWhiteFontWeightBold,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      }
                      return BottonAPP(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<CartCubit>().postProductToDataBase(
                                  name: name.text,
                                  address: address.text,
                                  phone: phone.text,
                                  detalsePluss: addDetalse.text,
                                );
                            Navigator.pushNamed(context, "/navBar");
                          }
                        },
                        nameBotton: "Checkout  ${widget.totleProduct} LE",
                        colorBotton: AppColors.primaryColor,
                        colorText: AppColors.white,
                        width: double.infinity,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    addDetalse.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }
}
