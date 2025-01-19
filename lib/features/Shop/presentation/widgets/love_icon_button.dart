// ignore_for_file: file_names

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:flutter/material.dart';

class LoveIconButton extends StatelessWidget {
  const LoveIconButton({
    super.key,
    required this.index,
    required this.getProductData,
  });
  final int index;
  final List<ProductsShop> getProductData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(71, 0, 0, 0),
            spreadRadius: 2,
            offset: Offset(5, 5),
            blurRadius: 10,
          ),
        ],
        color: ColorManager.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        icon: getProductData[index].favorte != null &&
                getProductData[index].favorte!.isNotEmpty
            //&&
            //  getProductData[index].favorte![0].isbool as bool
            ? const Icon(Icons.favorite, color: ColorManager.red)
            : const Icon(Icons.favorite_border),
      ),
    );
  }
}
