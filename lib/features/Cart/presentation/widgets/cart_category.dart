import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/chckout_and_delete.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/counter_add_and_remove.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    super.key,
    required this.cartModel,
    required this.carts,
    required this.index,
  });

  final CartModel cartModel;
  final List<CartModel> carts;
  final int index;
  @override
  Widget build(BuildContext context) {
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
                imageUrl: cartModel.products!.imageUrl.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    border: const Border.symmetric(
                        vertical: BorderSide(color: ColorManager.green)),
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 13.h,
              children: [
                //! prodoct name
                SizedBox(
                  width: 160.w,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    cartModel.products!.productName.toString(),
                    style: StyleTextApp.font14ColorblacFontWeightBold,
                  ),
                ),
                //! counter add and remove
                CunterAddandRemove(
                  price: cartModel,
                ),
                //! checkout and delete Buttons
                ChackoutAndDelete(
                  product: carts,
                  index: index,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
