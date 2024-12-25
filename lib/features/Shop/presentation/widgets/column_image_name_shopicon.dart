import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/reting_container.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/love_icon_button.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ColumnImageNameShopIcon extends StatelessWidget {
  const ColumnImageNameShopIcon({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        //! container image
        Stack(
          children: [
            Container(
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              bottom: 5.h,
              right: 5.w,
              //! love icon
              child: const LoveIconButton(),
            ),
            //! container reting
            Positioned(
              bottom: 5.h,
              left: 5.w,
              child: const ContainerReting(),
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
            SaleModel.salleSliderList[index].title,
            style: StyleTextApp.font14ColorblacFontWeightBold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //!  text for  price
            SizedBox(
              width: 55.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    "50\$",
                    style: StyleTextApp.font14ColorblacFontWeightBold,
                  ),
                  Text(
                    "209\$",
                    style:
                        StyleTextApp.font12ColorgrayTextDecorationlineThrough,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_sharp,
                color: ColorManager.green,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
