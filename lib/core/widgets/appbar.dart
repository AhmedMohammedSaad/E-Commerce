import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';

AppBar appBar({
  required bool leding,
  required String title,
}) {
  return AppBar(
    automaticallyImplyLeading: leding,
    // leading: const Icon(Icons.arrow_back_ios_new_rounded),
    title: Text(
      title,
      style: StyleTextApp.font14ColorblacFontWeightBold,
    ),
    actions: [
      Image.asset(
        'assets/images/logo png.png',
      )
    ],
  );
}
