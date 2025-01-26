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
            //! container image
            Stack(
              children: [
                Container(
                  height: 165.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // لون أسود مع شفافية
                        offset: Offset(5, 8), // اتجاه ومسافة الظل
                        blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                        spreadRadius: 1, // عرض الظل
                        blurRadius: 7, // نعومة الظل
                      ),
                    ],
                    //! image

                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ProductDetailsScreen(
                            index: index,
                            products: getProductData[index],
                            productID: getProductData[index],
                            // isFavorte: coubitData.chaickIsFavorte(
                            //     getProductData[index].productId!),
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
                              color: ColorManager.green,
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
                  //! love icon
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
                //! container reting
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
            //! product  name
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
                //! text for  price
                SizedBox(
                  width: 55.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        //! price name
                        //  overflow: TextOverflow.ellipsis,
                        "${getProductData[index].price.toString()} LE",
                        style: StyleTextApp.font13ColorblacFontWeightBold,
                      ),
                      //! old price
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
