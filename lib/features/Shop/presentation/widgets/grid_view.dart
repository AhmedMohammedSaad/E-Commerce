import 'dart:developer';

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/column_image_name_shopicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GridviewForWidget extends StatelessWidget {
  const GridviewForWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getProducts(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is ShopingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ShopingSuccses) {
            log("get data the SaleHome from api");
          }
        },
        builder: (context, state) {
          //! list of Product
          List<ProductsShop> getProductData =
              context.read<ShopCubit>().getProductsData;
          // log(getProductData.toString());
          // log(getProductData.length.toString());
          return state is ShopingLoading
              ? Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    size: 90,
                    color: ColorManager.green,
                  ),
                )
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: getProductData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 19.h,
                    crossAxisSpacing: 4.w,
                    mainAxisExtent: 270.h,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //! this container is for widget image and shop ....
                    return InkWell(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 240.h,
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
                );
        },
      ),
    )
        .animate()
        // .fadeIn(duration: 600.ms)
        .then(delay: 200.ms)
        .slide(
          begin: const Offset(1.1, 1.1), // Start from the right
          end: Offset.zero, // End at the original position
          duration: 300.ms,
        );
  }
}
