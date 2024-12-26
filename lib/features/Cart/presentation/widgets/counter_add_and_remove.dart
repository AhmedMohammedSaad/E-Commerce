import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:flutter/material.dart';

class CunterAddandRemove extends StatelessWidget {
  const CunterAddandRemove({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
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
