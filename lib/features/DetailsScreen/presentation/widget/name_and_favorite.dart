// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/textStyle/text_style.dart';

import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/love_icon_button.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NameAndFavorite extends StatelessWidget {
  const NameAndFavorite({
    super.key,
    required this.productID,
    required this.index,
    required this.products,
    required this.padding,
  });
  final dynamic productID;
  final int index;
  final dynamic products;
  final dynamic padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! name product
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              overflow: TextOverflow.ellipsis,
              products.productName.toString(),
              style: StyleTextApp.font16ColorblacFontWeightBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), //! Padding around the favorite button
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
                  child: BlocBuilder<ShopCubit, ShopState>(builder: (context, state) {
                    return LoveIconButton(
                      index: index,
                      getProductData: productID,
                      isFavorte: context.read<ShopCubit>().chaickIsFavorte(productID),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
