import 'dart:developer';

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/column_image_name_shopicon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesDetalse extends StatelessWidget {
  const CategoriesDetalse({
    super.key,
    required this.categorieName,
  });

  final String? categorieName;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit(apiConsumer: DioConsumer())
              ..getProducts(categorie: categorieName)),
        BlocProvider(
          create: (context) => CartCubit(apiConsumer: DioConsumer())..getCart(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is ShopingFailure) {
          } else if (state is ShopingSuccses) {
            log("get data the SaleHome from api");
          }
        },
        builder: (context, state) {
          var data = context.read<ShopCubit>().getProductsData;
//! new list from product list for search
          List<ProductsShop> filterList = [];

//! search products
          if (categorieName != null) {
            for (var x in data) {
              if (x.productCategory!.toLowerCase().trim() ==
                  categorieName!.toLowerCase().trim()) {
                filterList.add(x);
              }
            }
          }
          //! list of Product
          List<ProductsShop> getProductData = categorieName != null
              ? filterList
              : context.read<ShopCubit>().getProductsData;

          return state is ShopingLoading
              ? const LodingApp()
              : getProductData.isNotEmpty
                  ? GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: getProductData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 19.h,
                        crossAxisSpacing: 4.w,
                        mainAxisExtent: 290.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        //! this container is for widget image and shop ....
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 240.h,
                            width: 215.w,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26, // لون أسود مع شفافية
                                  offset: Offset(1, 1), // اتجاه ومسافة الظل
                                  blurStyle: BlurStyle
                                      .normal, // تأثير طبيعي على الحواف
                                  spreadRadius: 1, // عرض الظل
                                  blurRadius: 7, // نعومة الظل
                                ),
                              ],
                              border: Border.all(color: ColorManager.green),
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child:
                                //! column for image and text price and shop icon
                                ColumnImageNameShopIcon(
                              index: index,
                              getProductData: getProductData,
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "this Categorie is Empty",
                        style: StyleTextApp.font16ColorblacFontWeightBold,
                      ),
                    );
        },
      ),
    );
  }
}
