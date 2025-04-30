import 'dart:developer';

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/cubit/detailsscreen_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/pages/details_screen.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/column_image_name_shopicon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridviewForWidget extends StatefulWidget {
  const GridviewForWidget({
    super.key,
    this.quary,
  });
  final String? quary;

  @override
  State<GridviewForWidget> createState() => _GridviewForWidgetState();
}

class _GridviewForWidgetState extends State<GridviewForWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit(apiConsumer: DioConsumer())
            ..getProducts(quary: widget.quary),
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
            List<ProductsShop> getProductData = widget.quary != null
                ? context.read<ShopCubit>().searchList
                : context.read<ShopCubit>().getProductsData;

            if (state is ShopingLoading) {
              return const LodingApp();
            }

            if (getProductData.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 80.sp,
                      color: AppColors.primaryColor.withOpacity(0.5),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "No products found",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: getProductData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 0.60,
                  mainAxisExtent: 250.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final product = getProductData[index];
                  return Card(
                    color: AppColors.white,
                    elevation: 2,
                    shadowColor: const Color.fromARGB(214, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        // Navigate to product details
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
                                products: product,
                                productID: product,
                              ),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image - Fixed height
                            SizedBox(
                              height: 140.h,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  // Product image
                                  Positioned.fill(
                                    child: CachedNetworkImage(
                                      imageUrl: product.imageUrl ?? '',
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        color: const Color(0xFFF8F8F8),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        color: const Color(0xFFF8F8F8),
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Sale badge
                                  if (product.isSale == true)
                                    Positioned(
                                      top: 8.h,
                                      left: 8.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Text(
                                          "SALE",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Product Info - Use remainder of space with padding
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product name with constraints
                                    SizedBox(
                                      height: 36.h,
                                      child: Text(
                                        product.productName ??
                                            'Unknown Product',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),

                                    const Spacer(),

                                    // Price and Add to cart row at bottom
                                    SizedBox(
                                      height:
                                          product.isSale == true ? 40.h : 23.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          // Price column
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (product.isSale == true)
                                                Text(
                                                  "${product.oldPrice} LE",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              Text(
                                                "${product.price} LE",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Add to cart button
                                          _buildAddToCartButton(
                                              context, product),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, ProductsShop product) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final carts = context.read<CartCubit>().carts;
        final isProductInCart =
            carts.any((cart) => cart.products!.productId == product.productId);

        return Container(
          height: 32.h,
          width: 32.h,
          decoration: BoxDecoration(
            color:
                isProductInCart ? Colors.grey.shade400 : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: InkWell(
            onTap: () {
              if (isProductInCart) {
                // If product already in cart, show message
                if (mounted) {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.primaryColor,
                      content: Text(
                        "This product is already in your cart",
                        style: StyleTextApp.font14ColorWhiteFontWeightBold,
                      ),
                      // duration: const Duration(seconds: 2),
                    ),
                  );
                }
              } else {
                // Add to cart
                context.read<ShopCubit>().addToCart(
                      product.productId.toString(),
                    );

                // Show success message
                if (mounted) {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.primaryColor,
                      content: Text(
                        "Product added to cart successfully",
                        style: StyleTextApp.font14ColorWhiteFontWeightBold,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                context.read<CartCubit>().getCart();
              }
            },
            child: Icon(
              isProductInCart ? Icons.check : Icons.shopping_cart_rounded,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        );
      },
    );
  }
}
