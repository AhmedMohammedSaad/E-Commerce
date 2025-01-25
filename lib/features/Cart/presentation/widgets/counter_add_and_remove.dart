import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CunterAddandRemove extends StatelessWidget {
  const CunterAddandRemove({
    super.key,
    required this.price,
  });

  final CartModel price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //! prudct price
        SizedBox(
          width: 70.w,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "${price.products!.price} LE",
            style: StyleTextApp.font16ColorblacFontWeightBold,
          ),
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
              style: StyleTextApp.font14ColorblacFontWeightBold,
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
    );
  }
}
