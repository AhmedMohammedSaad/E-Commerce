import 'dart:developer';

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/column_image_name_shopicon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridviewForWidget extends StatelessWidget {
  const GridviewForWidget({
    super.key,
    this.quary,
  });
  final String? quary;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ShopCubit(apiConsumer: DioConsumer())..getProducts(quary: quary),
        ),
        BlocProvider(
          create: (context) => CartCubit(apiConsumer: DioConsumer())..getCart(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ShopCubit, ShopState>(
            listener: (context, state) {
              if (state is ShopingFailure) {
                // Handle failure
              } else if (state is ShopingSuccses) {
                log("get data the SaleHome from api");
              }
            },
          ),
        ],
        child: BlocBuilder<ShopCubit, ShopState>(
          builder: (context, state) {
            //! list of Product
            List<ProductsShop> getProductData = quary != null
                ? context.read<ShopCubit>().searchList
                : context.read<ShopCubit>().getProductsData;
            return state is ShopingLoading
                ? const LodingApp()
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: getProductData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 19.h,
                      crossAxisSpacing: 4.w,
                      mainAxisExtent: 285.h,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          height: 255.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26, // لون أسود مع شفافية
                                offset: Offset(1, 1), // اتجاه ومسافة الظل
                                blurStyle:
                                    BlurStyle.normal, // تأثير طبيعي على الحواف
                                spreadRadius: 1, // عرض الظل
                                blurRadius: 7, // نعومة الظل
                              ),
                            ],
                            border: Border.all(color: AppColors.primaryColor),
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: ColumnImageNameShopIcon(
                            index: index,
                            getProductData: getProductData,
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
