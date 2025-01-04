// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/botton_reviews.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/widget/rating.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//! Main screen to display product details
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.index,
  });
  final int index;
  //! The product object passed to the screen

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  //! Constant padding used across the widgets
  static const EdgeInsets padding = EdgeInsets.all(10.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! App bar with product category name, back button, and share button
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Expanded(
            child: Text(
              overflow: TextOverflow.ellipsis,
              SaleModel.salleSliderList[widget.index].title,
              style: StyleTextApp.font16ColorblacFontWeightBold,
            ),
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
            //! Widget to display product images in a list
            SizedBox(
              height: 300.h,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: SaleModel.salleSliderList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.green),
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          SaleModel.salleSliderList[index].image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return SizedBox(
                                height: 185.h,
                                width: 200.w,
                                child: Card(
                                  child: LoadingAnimationWidget.dotsTriangle(
                                    size: 90,
                                    color: ColorManager.green,
                                  ),
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                      )
                          .animate()
                          .fadeIn() // uses `Animate.defaultDuration`
                          .scale() // inherits duration from fadeIn
                          .move(delay: 20.ms, duration: 600.ms),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! name product
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        SaleModel.salleSliderList[widget.index].title,
                        style: StyleTextApp.font16ColorblacFontWeightBold,
                      ),
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
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border_outlined),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //! Product name and price section
            Padding(
              padding: padding,
              child: Text(
                "\$${SaleModel.salleSliderList[widget.index].price}",
                style: StyleTextApp.font14ColorblacFontWeightBold,
              ),
            ),
            //! Product detalse section
            Padding(
              padding: padding,
              child: Text(SaleModel.salleSliderList[widget.index].title,
                  style: StyleTextApp.font14Colorblac),
            ),
            //! Product rating section with animations
            Padding(
              padding: padding,
              child: Row(
                children: [
                  Rating(rating: 4.5),
                  Text("(${4.5})").animate().fadeIn().scale().move(
                        delay: 20.ms,
                        duration: 600.ms,
                      ),
                ],
              ),
            ),
            //! Product description section with animations
            Padding(
              padding: padding,
              child: Text(
                SaleModel.salleSliderList[widget.index].title,
                textAlign: TextAlign.start,
              ).animate().fadeIn().scale().move(delay: 20.ms, duration: 600.ms),
            ),
            SizedBox(height: 300),
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
              child: BottonReviews(
                onPressedToCart: () {},
              ),
            ))
      ]
          //! Listener for cart-related state changes
          // listener: (BuildContext context, AddToCartState state) {
          //   if (state is SuccessAddToCart) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text("Success Add To Cart")),
          //     );
          //   } else if (state is FillAddToCartInitial) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text(state.errorMasseg)),
          //     );
          //   }

          ),
    );
  }
}
