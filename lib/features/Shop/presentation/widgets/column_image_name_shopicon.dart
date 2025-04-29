import 'dart:developer';

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';

import 'package:advanced_app/features/DetailsScreen/presentation/pages/details_screen.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/add_to_cart.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/reting_container.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/love_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/cubit/detailsscreen_cubit.dart';

class ColumnImageNameShopIcon extends StatelessWidget {
  const ColumnImageNameShopIcon({
    super.key,
    required this.index,
    required this.getProductData,
  });
  final int index;
  final List<ProductsShop> getProductData;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
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
        final coubitData = context.read<ShopCubit>();
        return Column(
          spacing: 4,
          children: [
            Stack(
              children: [
                Container(
                  height: 170.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(5, 8),
                        blurStyle: BlurStyle.normal,
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => DetailsscreenCubit(
                                    apiConsumer: DioConsumer()),
                              ),
                              BlocProvider.value(
                                value: context.read<ShopCubit>(),
                              ),
                              BlocProvider.value(
                                value: context.read<CartCubit>(),
                              ),
                            ],
                            child: ProductDetailsScreen(
                              index: index,
                              products: getProductData[index],
                              productID: getProductData[index],
                            ),
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: CachedNetworkImage(
                        imageUrl: getProductData[index].imageUrl.toString(),
                        imageBuilder: (context, imageProvider) => Container(
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
                            child: LoadingAnimationWidget.dotsTriangle(
                              size: 90,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.broken_image_rounded,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.h,
                  right: 5.w,
                  child: BlocConsumer<ShopCubit, ShopState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return LoveIconButton(
                        isFavorte: coubitData
                            .chaickIsFavorte(getProductData[index].productId!),
                        index: index,
                        getProductData: getProductData[index],
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 5.h,
                  left: 5.w,
                  child: ContainerReting(
                      index: index, getProductData: getProductData),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                overflow: TextOverflow.ellipsis,
                getProductData[index].productName.toString(),
                style: StyleTextApp.font14ColorblacFontWeightBold,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 55.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        "${getProductData[index].price.toString()} LE",
                        style: StyleTextApp.font13ColorblacFontWeightBold,
                      ),
                      Text(
                        getProductData[index].oldPrice == null
                            ? ""
                            : "${getProductData[index].oldPrice.toString()} LE",
                        style: StyleTextApp
                            .font12ColorgrayTextDecorationlineThrough,
                      ),
                    ],
                  ),
                ),
                addToCartForProduct(
                  getProductData[index],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
