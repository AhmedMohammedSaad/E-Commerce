// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/cubit/detailsscreen_cubit.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/add_to_cart_botton.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/app_bar.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/list_of_products.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/rating.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        appBar: appBarDetalles(context, widget.products),
        body: Stack(children: [
          //! ListView containing product details and images
          listOfProductNameAndImageAndPrice(
            context,
            padding,
            widget.index,
            widget.productID,
            widget.products,
          ),
          //! Positioned widget for the bottom section containing the "Add to Cart" button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: addToCartBottn(context, widget.productID),
          ),
        ]),
      ),
    );
  }
}
