import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/reting_container.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/love_icon_button.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                image: DecorationImage(
                  image: NetworkImage(
                    SaleModel.salleSliderList[index].image,
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(14.r),
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
        Text(
          SaleModel.salleSliderList[index].title,
          style: StyleTextApp.font14ColorblacFontWeightBold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //!  text for  price
            Text(
              "13\$",
              style: StyleTextApp.font14ColorblacFontWeightBold,
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
