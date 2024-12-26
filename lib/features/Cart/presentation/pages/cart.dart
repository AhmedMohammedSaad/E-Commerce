import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! AppBar
      appBar: appBar(leding: false, title: 'Cart'),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: SaleModel.salleSliderList.length,
        itemBuilder: (BuildContext context, int index) {
          //! this container is for widget image and shop ....
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            height: 150.h,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26, // لون أسود مع شفافية
                  offset: Offset(1, 1), // اتجاه ومسافة الظل
                  blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                  spreadRadius: 1, // عرض الظل
                  blurRadius: 7, // نعومة الظل
                ),
              ],
              border: Border.all(color: ColorManager.green),
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            //!
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! this sizdBox is for size image and style
                SizedBox(
                  height: 150.h,
                  width: 150.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      bottomLeft: Radius.circular(14.r),
                    ),
                    //! image
                    child: CachedNetworkImage(
                      imageUrl: SaleModel.salleSliderList[index].image,
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
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 13.h,
                    children: [
                      //! prodoct name
                      SizedBox(
                        width: 160.w,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          SaleModel.salleSliderList[index].title,
                          style: StyleTextApp.font14ColorblacFontWeightBold,
                        ),
                      ),
                      Row(
                        children: [
                          //! prudct price
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "${SaleModel.salleSliderList[index].price}\$",
                            style: StyleTextApp.font20ColorManColor,
                          ),
                          //! this row is tow button counter add and munes
                          Row(
                            children: [
                              //! munes counter
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: ColorManager.green,
                                ),
                              ),
                              //! counter
                              Text(
                                '0',
                                style:
                                    StyleTextApp.font14ColorblacFontWeightBold,
                              ),
                              //! add counter
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  color: ColorManager.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //! checkout and delete Buttons
                      Row(
                        spacing: 4,
                        children: [
                          //! checkout button
                          Container(
                            alignment: Alignment.center,
                            height: 30.h,
                            width: 80.w,
                            color: ColorManager.green,
                            child: Text(
                              "Checkout",
                              style:
                                  StyleTextApp.font14ColorWhiteFontWeightBold,
                            ),
                          ),
                          //! delete button
                          Container(
                            alignment: Alignment.center,
                            height: 30.h,
                            width: 80.w,
                            color: ColorManager.red,
                            child: Text(
                              "Delete",
                              style:
                                  StyleTextApp.font14ColorWhiteFontWeightBold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
          .animate()
          // .fadeIn(duration: 600.ms)
          .then(delay: 200.ms)
          .slide(
            begin: const Offset(1.1, 1.1), // Start from the right
            end: Offset.zero, // End at the original position
            duration: 300.ms,
          ),
    );
  }
}
