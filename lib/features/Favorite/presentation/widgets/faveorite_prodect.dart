import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/Favorite/data/models/favorite_model/favorite_model.dart';
import 'package:advanced_app/features/Favorite/presentation/widgets/delete_product.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FavortColumnImageNameShopIcon extends StatelessWidget {
  const FavortColumnImageNameShopIcon({
    super.key,
    required this.index,
    required this.favorite,
    required this.listFavorite,
  });
  final int index;
  final FavoriteModel favorite;
  final List<FavoriteModel> listFavorite;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(apiConsumer: DioConsumer())..getCart(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit(apiConsumer: DioConsumer()),
        ),
      ],
      child: Column(
        spacing: 4,
        children: [
          //! container image
          Stack(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: CachedNetworkImage(
                      imageUrl: favorite.products!.imageUrl.toString(),
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
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 5.h,
              //   right: 5.w,
              //   //! love icon
              //   child: const LoveIconButton(index:  index, getProductData: [],),
              // ),
              //! container Delete
              Positioned(
                top: 1.h,
                left: 1.w,
                child: ButtonDelete(
                  favoriteId: favorite,
                  index: index,
                  listFavorite: listFavorite,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          //! text title name
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              overflow: TextOverflow.ellipsis,
              favorite.products!.productName.toString(),
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
                      overflow: TextOverflow.ellipsis,

                      "${favorite.products!.price.toString()} LE",
                      style: StyleTextApp.font14ColorblacFontWeightBold,
                    ),
                    Text(
                      "${favorite.products!.oldPrice.toString()} LE",
                      style: StyleTextApp.font12ColorgrayTextDecorationlineThrough,
                    ),
                  ],
                ),
              ),

              BlocBuilder<ShopCubit, ShopState>(builder: (context, state) {
                return BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        final carts = context.read<CartCubit>().carts;

                        // التحقق من وجود المنتج في السلة
                        final isProductInCart =
                            carts.any((cart) => cart.products!.productId == listFavorite[index].products!.productId);

                        if (isProductInCart) {
                          // إذا كان المنتج موجودًا في السلة، عرض رسالة
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primaryColor,
                                content: Text(
                                  "تمت الإضافة إلى السلة مسبقًا",
                                  style: StyleTextApp.font14ColorWhiteFontWeightBold,
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          });
                        } else {
                          // إذا لم يكن المنتج موجودًا في السلة، إضافته
                          context.read<ShopCubit>().addToCart(
                                listFavorite[index].products!.productId.toString(),
                              );

                          // عرض رسالة نجاح
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primaryColor,
                                content: Text(
                                  "تمت الإضافة إلى السلة بنجاح",
                                  style: StyleTextApp.font14ColorWhiteFontWeightBold,
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          });
                        }
                        context.read<CartCubit>().getCart();
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
