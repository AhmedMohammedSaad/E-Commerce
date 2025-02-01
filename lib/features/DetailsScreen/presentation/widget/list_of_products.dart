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
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ListOfProducts listOfProductNameAndImageAndPrice(
  BuildContext context,
  padding,
  int index,
  ProductsShop productID,
  ProductsShop products,
) {
  return ListOfProducts(
    index: index,
    productID: productID,
    products: products,
    padding: padding,
  );
}

class ListOfProducts extends StatefulWidget {
  const ListOfProducts({
    super.key,
    this.padding,
    required this.index,
    required this.productID,
    required this.products,
  });
  final padding;
  final int index;
  final ProductsShop productID;
  final ProductsShop products;

  @override
  State<ListOfProducts> createState() => _ListOfProductsState();
}

class _ListOfProductsState extends State<ListOfProducts> {
  int counterNumber = 1; // بداية العداد من 1

  void counterAdd() {
    setState(() {
      counterNumber++;
    });
  }

  void counterDelete() {
    setState(() {
      if (counterNumber > 1) {
        // التأكد من أن العداد لا يقل عن 1
        counterNumber--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int price = int.parse(widget.products.price.toString());
    // حساب المبلغ الإجمالي
    int totalPrice = counterNumber * price;
    return ListView(
      children: [
        //! Widget to display product images
        ImageProductDetalse(
          products: widget.products,
        )
            .animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(delay: 20.ms, duration: 600.ms),
        SizedBox(height: 20),
        //! Product name section
        NameAndFavorite(
          productID: widget.productID,
          index: widget.index,
          padding: widget.padding,
          products: widget.products,
        ),
        //!  price section
        Padding(
          padding: widget.padding,
          child: Row(
            spacing: 20.w,
            children: [
              //! price
              Text(
                "$totalPrice LE",
                style: StyleTextApp.font14ColorblacFontWeightBold,
              ),

              //! old price
              Text(
                "${widget.products.oldPrice.toString()} LE",
                style: StyleTextApp.font14ColorgrayTextDecorationlineThrough,
              ),
              Row(
                children: [
                  //! زر النقصان
                  IconButton(
                    onPressed: () {
                      counterDelete();
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: ColorManager.green,
                    ),
                  ),
                  //! عرض العداد
                  Text(
                    counterNumber.toString(),
                    style: StyleTextApp.font14ColorblacFontWeightBold,
                  ),
                  //! زر الزيادة
                  IconButton(
                    onPressed: () {
                      counterAdd();
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      color: ColorManager.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        //! Product detalse section
        Padding(
          padding: widget.padding,
          child: Text(widget.products.discription.toString(),
              style: StyleTextApp.font14Colorblac),
        ),
        //!  rating section with animations
        Padding(
          padding: widget.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RatingStar(
                    rating: double.parse(widget.products.rating != null &&
                            widget.products.rating!.isNotEmpty
                        ? widget.products.rating![0].ratingNum.toString()
                        : "0"),
                  ),
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
              BottonAPP(
                onTap: () {
                  addCommentAndRatingDialog(context, widget.productID);
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
}
