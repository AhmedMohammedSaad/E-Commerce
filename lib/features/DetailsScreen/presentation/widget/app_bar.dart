import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar appBarDetalles(BuildContext context, products) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
    title: SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Text(
        overflow: TextOverflow.ellipsis,
        products.productName.toString(),
        style: StyleTextApp.font16ColorblacFontWeightBold,
      ),
    ),
    actions: [
      Image(
          width: 140.w,
          image: const AssetImage(
            'assets/images/logo png.png',
          ))
    ],
  );
}
