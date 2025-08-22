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
import 'package:easy_localization/easy_localization.dart';

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

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  final Rating rating = Rating();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

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
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor,
            ),
          ).animate().slideX(
                begin: -1,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutQuad,
              ),
          title: Text(
            widget.products.productName.toString(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          )
              .animate()
              .fadeIn(
                duration: 400.ms,
                curve: Curves.easeOut,
              )
              .slideX(
                begin: 0.2,
                end: 0,
                duration: 400.ms,
              ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Image(
                width: 40.w,
                image: const AssetImage("assets/images/logo.png"),
              ),
            ).animate().fadeIn(
                  delay: 100.ms,
                  duration: 400.ms,
                ),
          ],
        ),
        body: Stack(
          children: [
            // Main content with hero effect
            Hero(
              tag: 'product_${widget.productID.productId}',
              flightShuttleBuilder: (_, animation, __, ___, ____) {
                return Container(
                  color: Colors.transparent,
                );
              },
              child: Material(
                color: Colors.transparent,
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 120.h),
                  children: [
                    // Product image with parallax effect
                    Container(
                      height: 373.h,
                      width: double.infinity,
                      margin: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: AnimatedBuilder(
                          animation: _scrollController,
                          builder: (context, child) {
                            final double parallaxOffset =
                                _scrollController.hasClients
                                    ? (_scrollController.offset / 500)
                                        .clamp(-1.0, 1.0)
                                    : 0.0;

                            return CachedNetworkImage(
                              imageUrl: widget.products.imageUrl.toString(),
                              fit: BoxFit.cover,
                              alignment: Alignment(0, parallaxOffset),
                              placeholder: (context, url) => Center(
                                child: LoadingAnimationWidget.dotsTriangle(
                                  size: 50,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 40.sp,
                                color: Colors.red[300],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                        .slideY(
                            begin: 0.2,
                            end: 0,
                            duration: 700.ms,
                            curve: Curves.easeOutQuint)
                        .scale(
                          begin: Offset(0.9, 0.9),
                          end: Offset(1.0, 1.0),
                          duration: 700.ms,
                          curve: Curves.easeOut,
                        ),

                    // Product info card with staggered animations for children
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product name and favorite button
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  widget.products.productName.toString(),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    height: 1.3,
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 200.ms, duration: 400.ms)
                                    .slideX(
                                        begin: -0.2,
                                        end: 0,
                                        delay: 200.ms,
                                        duration: 400.ms,
                                        curve: Curves.easeOutQuad),
                              ),
                              BlocBuilder<ShopCubit, ShopState>(
                                builder: (context, state) {
                                  return Container(
                                    height: 46.h,
                                    width: 46.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: LoveIconButton(
                                      index: widget.index,
                                      getProductData: widget.productID,
                                      isFavorte: context
                                          .read<ShopCubit>()
                                          .chaickIsFavorte(widget.productID),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 300.ms, duration: 400.ms)
                                      .scale(
                                          delay: 300.ms,
                                          duration: 400.ms,
                                          curve: Curves.elasticOut);
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // Rating section with sequential fade ins
                          Row(
                            children: [
                              RatingStar(
                                rating: double.parse(
                                    widget.products.rating != null &&
                                            widget.products.rating!.isNotEmpty
                                        ? widget.products.rating![0].ratingNum
                                            .toString()
                                        : "0"),
                              )
                                  .animate()
                                  .fadeIn(delay: 400.ms, duration: 400.ms)
                                  .slideX(
                                      begin: -0.2,
                                      end: 0,
                                      delay: 400.ms,
                                      duration: 400.ms),
                              SizedBox(width: 6.w),
                              Text(
                                "(${widget.products.rating != null && widget.products.rating!.isNotEmpty ? widget.products.rating!.length : 0} reviews)",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 500.ms, duration: 400.ms)
                                  .slideX(
                                      begin: -0.2,
                                      end: 0,
                                      delay: 500.ms,
                                      duration: 400.ms),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // Price section with shimmer effect
                          Row(
                            children: [
                              Text(
                                "${widget.products.price.toString()} LE",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ).animate().custom(
                                    duration: 600.ms,
                                    delay: 600.ms,
                                    begin: 0,
                                    end: 1,
                                    builder: (context, value, child) {
                                      return ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (bounds) {
                                          return LinearGradient(
                                            colors: [
                                              AppColors.primaryColor,
                                              Colors.purple.shade300,
                                              AppColors.primaryColor,
                                            ],
                                            stops: [0, value, 1],
                                          ).createShader(
                                            Rect.fromLTWH(
                                              -bounds.width +
                                                  (bounds.width * 2 * value),
                                              0,
                                              bounds.width * 2,
                                              bounds.height,
                                            ),
                                          );
                                        },
                                        child: child,
                                      );
                                    },
                                  ),
                              SizedBox(width: 12.w),
                              if (widget.products.oldPrice != null)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    "${widget.products.oldPrice.toString()} LE",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red[400],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 700.ms, duration: 400.ms)
                                    .scale(
                                        begin: Offset(0.8, 0.8),
                                        end: Offset(1.0, 1.0),
                                        delay: 700.ms,
                                        duration: 400.ms),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideY(
                        begin: 0.3, end: 0, delay: 200.ms, duration: 500.ms),

                    // Description section with typing text effect
                    Container(
                      margin: EdgeInsets.all(16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "description".tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 800.ms, duration: 400.ms)
                              .slideX(
                                  begin: -0.2,
                                  end: 0,
                                  delay: 800.ms,
                                  duration: 400.ms),
                          SizedBox(height: 12.h),
                          Text(
                            widget.products.discription.toString(),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black54,
                              height: 1.5,
                            ),
                          ).animate().custom(
                                delay: 900.ms,
                                duration: 1200.ms,
                                builder: (context, value, child) {
                                  return Text(
                                    widget.products.discription
                                        .toString()
                                        .substring(
                                            0,
                                            (widget.products.discription
                                                        .toString()
                                                        .length *
                                                    value)
                                                .toInt()),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black54,
                                      height: 1.5,
                                    ),
                                  );
                                },
                              ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 800.ms, duration: 500.ms).slideY(
                        begin: 0.3, end: 0, delay: 800.ms, duration: 500.ms),

                    // Reviews section with flip card animations
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "reviews".tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 1000.ms, duration: 400.ms)
                              .slideX(
                                  begin: -0.2,
                                  end: 0,
                                  delay: 1000.ms,
                                  duration: 400.ms),
                          SizedBox(height: 16.h),
                          BlocConsumer<DetailsscreenCubit, DetailsscreenState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              List<Comments> comments = context
                                  .read<DetailsscreenCubit>()
                                  .commentsList;

                              if (state is CommentLoading) {
                                return Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: LoadingAnimationWidget.dotsTriangle(
                                      size: 40,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                );
                              } else if (state is CommentSuccses) {
                                if (comments.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.h),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.chat_bubble_outline,
                                            size: 40.sp,
                                            color: Colors.grey[400],
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            "no_reviews_yet".tr(),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      )
                                          .animate()
                                          .fadeIn(
                                              delay: 1200.ms, duration: 600.ms)
                                          .scale(
                                              begin: Offset(0.8, 0.8),
                                              end: Offset(1.0, 1.0),
                                              delay: 1200.ms,
                                              duration: 600.ms),
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: comments.length,
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey[200],
                                    height: 20.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    final comment = comments[index];

                                    if (comment.comments != null &&
                                        comment.comments!.isNotEmpty) {
                                      final innerComment = comment.comments![0];
                                      final user = innerComment.users?.name ??
                                          "unknown_user".tr();
                                      final comm = innerComment.comment ??
                                          "no_comment".tr();

                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20.r,
                                                  backgroundColor: AppColors
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                                  child: Text(
                                                    user.isNotEmpty
                                                        ? user[0].toUpperCase()
                                                        : "U",
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                                    .animate(
                                                      delay: 1100.ms +
                                                          (index * 200).ms,
                                                      onPlay: (controller) =>
                                                          controller.repeat(
                                                              reverse: true),
                                                    )
                                                    .shimmer(
                                                        duration: 1800.ms,
                                                        delay: 1100.ms +
                                                            (index * 100).ms),
                                                SizedBox(width: 12.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      user,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ).animate().fadeIn(
                                                  delay: 1100.ms +
                                                      (index * 100).ms,
                                                  duration: 500.ms,
                                                ),
                                            SizedBox(height: 8.h),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 52.w),
                                              child: Text(
                                                comm,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.black54,
                                                  height: 1.4,
                                                ),
                                              ),
                                            ).animate().fadeIn(
                                                  delay: 1200.ms +
                                                      (index * 100).ms,
                                                  duration: 500.ms,
                                                ),
                                          ],
                                        ),
                                      ).animate().flipV(
                                            delay: 1100.ms + (index * 100).ms,
                                            duration: 600.ms,
                                            begin: -0.1,
                                            end: 0,
                                            curve: Curves.easeOutBack,
                                          );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                );
                              }

                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Text(
                                    "failed_load_reviews".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 1100.ms, duration: 400.ms);
                            },
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 1000.ms, duration: 500.ms).slideY(
                        begin: 0.3, end: 0, delay: 1000.ms, duration: 500.ms),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom "Add to Cart" bar with hover animation and pulse effect
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTapDown: (_) => _animationController.forward(),
                onTapUp: (_) => _animationController.reverse(),
                onTapCancel: () => _animationController.reverse(),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: BlocBuilder<ShopCubit, ShopState>(
                      builder: (context, state) {
                        return BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            if (state is GetCartLoding) {
                              return Center(
                                child: LoadingAnimationWidget.dotsTriangle(
                                  size: 40,
                                  color: AppColors.primaryColor,
                                ),
                              );
                            }

                            return BottonReviews(
                              onPressedToCart: () {
                                final carts = context.read<CartCubit>().carts;
                                final isProductInCart = carts.any(
                                  (cart) =>
                                      cart.products!.productId ==
                                      widget.productID.productId,
                                );

                                if (isProductInCart) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primaryColor,
                                        content: Text(
                                          "product_already_in_cart".tr(),
                                          style: StyleTextApp
                                              .font14ColorWhiteFontWeightBold,
                                        ),
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        margin: EdgeInsets.all(16),
                                      ),
                                    );
                                  });
                                } else {
                                  context.read<ShopCubit>().addToCart(
                                        widget.productID.productId.toString(),
                                      );

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primaryColor,
                                        content: Text(
                                          "added_to_cart_successfully".tr(),
                                          style: StyleTextApp
                                              .font14ColorWhiteFontWeightBold,
                                        ),
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        margin: EdgeInsets.all(16),
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
              ),
            ).animate().fadeIn(delay: 1200.ms, duration: 500.ms).moveY(
                begin: 50,
                end: 0,
                delay: 1200.ms,
                duration: 800.ms,
                curve: Curves.elasticOut),
          ],
        ),
      ),
    );
  }
}
