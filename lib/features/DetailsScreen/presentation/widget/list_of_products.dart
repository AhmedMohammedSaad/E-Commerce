// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/add_comments_and_rat.dart';

import 'package:advanced_app/features/DetailsScreen/presentation/widget/comments.dart';

import 'package:advanced_app/features/DetailsScreen/presentation/widget/devider_widgets.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/image_product_detalse.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/name_and_favorite.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/rating.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ListView listOfProductNameAndImageAndPrice(
  BuildContext context,
  padding,
  int index,
  productID,
  products,
) {
  return ListView(
    children: [
      //! Widget to display product images
      ImageProductDetalse(
        products: products,
      )
          .animate()
          .fadeIn() // uses `Animate.defaultDuration`
          .scale() // inherits duration from fadeIn
          .move(delay: 20.ms, duration: 600.ms),
      SizedBox(height: 20),
      //! Product name section
      NameAndFavorite(
        productID: productID,
        index: index,
        padding: padding,
        products: products,
      ),
      //!  price section
      Padding(
        padding: padding,
        child: Row(
          spacing: 20.w,
          children: [
            //! price
            Text(
              "${products.price.toString()} LE",
              style: StyleTextApp.font14ColorblacFontWeightBold,
            ),

            //! old price
            Text(
              "${products.oldPrice.toString()} LE",
              style: StyleTextApp.font14ColorgrayTextDecorationlineThrough,
            ),
          ],
        ),
      ),
      //! Product detalse section
      Padding(
        padding: padding,
        child: Text(products.discription.toString(),
            style: StyleTextApp.font14Colorblac),
      ),
      //!  rating section with animations
      Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingStar(
                  rating: double.parse(
                      products.rating != null && products.rating!.isNotEmpty
                          ? products.rating![0].ratingNum.toString()
                          : "0"),
                ),
                Text("(${products.rating != null && products.rating!.isNotEmpty ? products.rating!.length : 0})")
                    .animate()
                    .fadeIn()
                    .scale()
                    .move(
                      delay: 20.ms,
                      duration: 600.ms,
                    ),
              ],
            ),
            BottonAPP(
              onTap: () {
                addCommentAndRatingDialog(
                  context,
                );
              },
              nameBotton: "Add Comment & Rat",
              colorBotton: ColorManager.green,
              colorText: ColorManager.white,
              width: 195.w,
            ),
          ],
        ),
      ),

      //! Divider widget for comments
      DivideWidgetComments(),
      //! product Comments
      ProductComments(),
      SizedBox(height: 200),
    ].animate().fadeIn().scale().move(
          delay: 20.ms,
          duration: 600.ms,
        ),
  );
}
