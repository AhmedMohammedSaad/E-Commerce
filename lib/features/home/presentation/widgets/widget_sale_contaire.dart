import 'dart:developer';

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/pages/details_screen.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../Shop/presentation/cubit/shop_cubit.dart';

class SlaleWidgetContainer extends StatelessWidget {
  const SlaleWidgetContainer({
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
          //! list view of Product
          final List<ProductsShop> getProductSale =
              context.read<ShopCubit>().getProductsData;
          return state is ShopingLoading
              ? Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    size: 90,
                    color: ColorManager.green,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  primary: true,
                  itemCount: getProductSale.length,
                  itemBuilder: (BuildContext context, int index) {
                    // bool isSale = getProductSale[index].isSale != null &&
                    //     getProductSale[index].isSale != false;
                    if (getProductSale[index].isSale == true) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ProductDetailsScreen(
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.h),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                height: 185.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color:
                                          Colors.black26, // لون أسود مع شفافية
                                      offset: Offset(3, 5), // اتجاه ومسافة الظل
                                      blurStyle: BlurStyle
                                          .normal, // تأثير طبيعي على الحواف
                                      spreadRadius: 2, // عرض الظل
                                      blurRadius: 11, // نعومة الظل
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14.r),
                                  //! iamge product
                                  child: CachedNetworkImage(
                                    imageUrl: getProductSale[index]
                                        .imageUrl
                                        .toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => SizedBox(
                                      height: 185.h,
                                      width: 200.w,
                                      child: Card(
                                        child:
                                            LoadingAnimationWidget.dotsTriangle(
                                          size: 80,
                                          color: ColorManager.green,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.broken_image_rounded,
                                            size: 50),
                                  ),
                                ),
                              ),
                            ),
                            //! container Sales
                            Positioned(
                              top: 8.h, // المسافة من الأعلى
                              right: 28.w, // المسافة من اليمين
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.h,
                                width: 44.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color:
                                          Colors.black26, // لون أسود مع شفافية
                                      offset: Offset(4, 4), // اتجاه ومسافة الظل
                                      blurStyle: BlurStyle
                                          .normal, // تأثير طبيعي على الحواف
                                      spreadRadius: 2, // عرض الظل
                                      blurRadius: 8, // نعومة الظل
                                    ),
                                  ],
                                  color: ColorManager.green, // لون الشريط
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(7.r),
                                    bottomRight: Radius.circular(7.r),
                                  ),
                                ),
                                //! text Sale
                                child: Text(
                                    '${calculateSaleOffer(
                                      int.tryParse(getProductSale[index]
                                              .price
                                              .toString()) ??
                                          0,
                                      int.tryParse(getProductSale[index]
                                              .oldPrice
                                              .toString()) ??
                                          0,
                                    )}% OFF',
                                    style: StyleTextApp
                                        .font14ColorWhiteFontWeightBold),
                              ),
                            ),
                            //! the container is Opacity
                            Positioned(
                              bottom: 8.h,
                              left: 16.w,
                              child: Container(
                                alignment: Alignment.center,
                                height: 40.h,
                                width: MediaQuery.of(context).size.width * 0.91,
                                decoration: BoxDecoration(
                                  color: ColorManager.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14.r),
                                    bottomRight: Radius.circular(14.r),
                                  ),
                                ),
                                //! text title
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.86,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    getProductSale[index]
                                        .productName
                                        .toString(),
                                    style: StyleTextApp
                                        .font14ColorWhiteFontWeightBold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            .animate()
                            // .fadeIn(duration: 600.ms)
                            .then(delay: 200.ms)
                            .slide(
                              begin: const Offset(
                                  0.1, 1.0), // Start from the right
                              end: Offset.zero, // End at the original position
                              duration: 200.ms,
                            ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
        },
      ),
    );
  }

  //! function calculate Sale Offer
  int calculateSaleOffer(int price, int oldPrice) {
    if (oldPrice <= 0 || price < 0 || price > oldPrice) {
      throw ArgumentError("Invalid price or old price values.");
    }

    double discountPercentage = ((oldPrice - price) / oldPrice) * 100;
    return discountPercentage.toInt();
  }
}
