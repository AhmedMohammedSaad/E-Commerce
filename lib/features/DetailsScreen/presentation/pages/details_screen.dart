// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/data/models/comments/comments.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/cubit/detailsscreen_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/botton_reviews.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/devider_widgets.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/rating.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/rating.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/love_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//! Main screen to display product details
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.index,
    required this.products,
    required this.productID,
  });
  final int index;
  final ProductsShop productID;
  //! The product object passed to the screen
  final ProductsShop products;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final Rating rating = Rating();

  //! Constant padding used across the widgets
  static const EdgeInsets padding = EdgeInsets.all(10.0);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsscreenCubit(apiConsumer: DioConsumer())
            ..getComments(widget.productID.productId),
        ),
        BlocProvider(
            create: (context) => ShopCubit(apiConsumer: DioConsumer())),
        BlocProvider(
          create: (context) => CartCubit(apiConsumer: DioConsumer())..getCart(),
        ),
      ],
      child: Scaffold(
        //! App bar with product category name, back button, and share button
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              overflow: TextOverflow.ellipsis,
              widget.products.productName.toString(),
              style: StyleTextApp.font16ColorblacFontWeightBold,
            ),
          ),
          actions: [
            Image(
                width: 140.w,
                image: const AssetImage(
                  'assets/images/logo png.png',
                ))
          ],
        ),
        body: Stack(children: [
          //! ListView containing product details and images
          ListView(
            children: [
              //! Widget to display product images
              SizedBox(
                height: 300.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.green),
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.products.imageUrl.toString(),
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )),
                ),
              )
                  .animate()
                  .fadeIn() // uses `Animate.defaultDuration`
                  .scale() // inherits duration from fadeIn
                  .move(delay: 20.ms, duration: 600.ms),
              SizedBox(height: 20),
              //! Product name section
              Padding(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //! name product
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        widget.products.productName.toString(),
                        style: StyleTextApp.font16ColorblacFontWeightBold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          8.0), //! Padding around the favorite button
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        //! IconButton for marking product as favorite
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: BlocBuilder<ShopCubit, ShopState>(
                                builder: (context, state) {
                              return LoveIconButton(
                                index: widget.index,
                                getProductData: widget.productID,
                                isFavorte: context
                                    .read<ShopCubit>()
                                    .chaickIsFavorte(widget.productID),
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //!  price section
              Padding(
                padding: padding,
                child: Row(
                  spacing: 20.w,
                  children: [
                    //! price
                    Text(
                      "${widget.products.price.toString()} LE",
                      style: StyleTextApp.font14ColorblacFontWeightBold,
                    ),

                    //! old price
                    Text(
                      "${widget.products.oldPrice.toString()} LE",
                      style:
                          StyleTextApp.font14ColorgrayTextDecorationlineThrough,
                    ),
                  ],
                ),
              ),
              //! Product detalse section
              Padding(
                padding: padding,
                child: Text(widget.products.discription.toString(),
                    style: StyleTextApp.font14Colorblac),
              ),
              //! Product rating section with animations
              Padding(
                padding: padding,
                child: Row(
                  children: [
                    RatingStar(
                      rating: double.parse(widget.products.rating != null &&
                              widget.products.rating!.isNotEmpty
                          ? widget.products.rating![0].ratingNum.toString()
                          : "0"),
                    ),
                    // widget.products.rating?[widget.index].ratingNum
                    //         ?.toDouble() ??

                    Text("(${widget.products.rating != null && widget.products.rating!.isNotEmpty ? widget.products.rating!.length : 0})")
                        .animate()
                        .fadeIn()
                        .scale()
                        .move(
                          delay: 20.ms,
                          duration: 600.ms,
                        ),
                  ],
                ),
              ),
              //! Product description section with animations
              // Padding(
              //   padding: padding,
              //   child: Text(
              //     SaleModel.salleSliderList[widget.index].title,
              //     textAlign: TextAlign.start,
              //   ).animate().fadeIn().scale().move(delay: 20.ms, duration: 600.ms),
              // ),

              //! Divider widget for comments
              DivideWidgetComments(),
              //! product Comments
              BlocConsumer<DetailsscreenCubit, DetailsscreenState>(
                listener: (BuildContext context, state) {},
                builder: (BuildContext context, state) {
                  List<Comments> comments =
                      context.read<DetailsscreenCubit>().commentsList;
                  if (state is CommentLoading) {
                    return Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        size: 80,
                        color: ColorManager.green,
                      ),
                    );
                  } else if (state is CommentSuccses) {
                    if (comments.isEmpty) {
                      return Center(child: Text("No Comments Available"));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (BuildContext context, int index) {
                        final comment = comments[index];
                        // طباعة التعليق

                        if (comment.comments != null &&
                            comment.comments!.isNotEmpty) {
                          // استخدام الفهرس 0 للوصول إلى أول تعليق (أو أي index آخر إذا كنت تريد عنصرًا محددًا)
                          final innerComment = comment.comments![0];
                          final user = innerComment.users?.name ??
                              "Unknown User"; // قيمة افتراضية
                          final comm = innerComment.comment ??
                              "No comment"; // قيمة افتراضية

                          return ListTile(
                            title: Text(
                              user.toString(),
                              style: StyleTextApp.font14ColorblacFontWeightBold,
                            ),
                            subtitle: Text(
                              comm.toString(),
                              style: StyleTextApp.font14Colorblac,
                            ),
                          );
                        } else {
                          return ListTile(
                            title: Text(
                              "Name",
                              style: StyleTextApp.font14ColorblacFontWeightBold,
                            ),
                            subtitle: Text(
                              "No comment available",
                              style: StyleTextApp.font14Colorblac,
                            ),
                          );
                        }
                      },
                    );
                  }

                  return Center(child: Text("No Internet"));
                },
              ),
              SizedBox(height: 200),
            ].animate().fadeIn().scale().move(
                  delay: 20.ms,
                  duration: 600.ms,
                ),
          ).animate().fadeIn().scale().move(
                delay: 20.ms,
                duration: 600.ms,
              ),
          //! Positioned widget for the bottom section containing the "Add to Cart" button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 112.h,
              color: Colors.white,
              child: BlocBuilder<ShopCubit, ShopState>(
                builder: (context, state) {
                  return BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return state is GetCartLoding
                          ? Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                size: 60,
                                color: ColorManager.green,
                              ),
                            )
                          : BottonReviews(
                              onPressedToCart: () {
                                final carts = context.read<CartCubit>().carts;

                                // التحقق من وجود المنتج في السلة
                                final isProductInCart = carts.any(
                                  (cart) =>
                                      cart.products!.productId ==
                                      widget.productID.productId,
                                );

                                if (isProductInCart) {
                                  // إذا كان المنتج موجودًا في السلة، عرض رسالة
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: ColorManager.green,
                                        content: Text(
                                          "تمت الإضافة إلى السلة مسبقًا",
                                          style: StyleTextApp
                                              .font14ColorWhiteFontWeightBold,
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  });
                                } else {
                                  // إذا لم يكن المنتج موجودًا في السلة، إضافته
                                  context.read<ShopCubit>().addToCart(
                                        widget.productID.productId.toString(),
                                      );

                                  // عرض رسالة نجاح
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: ColorManager.green,
                                        content: Text(
                                          "تمت الإضافة إلى السلة بنجاح",
                                          style: StyleTextApp
                                              .font14ColorWhiteFontWeightBold,
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  });
                                }
                                context.read<CartCubit>().getCart();
                              },
                            );
                    },
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
