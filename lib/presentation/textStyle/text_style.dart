// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/colors.dart';
import 'package:flutter/widgets.dart';

//! the class he is text syle in app
class StyleTextApp {
  static final font12ColorMainColor = TextStyle(
    color: ColorManager.grey,
    fontSize: 12,
  );
  static final font14ColorMainColor = TextStyle(
    color: const Color.fromARGB(255, 180, 180, 178),
    fontSize: 14,
  );
  static final font20ColorMainColor = TextStyle(
    color: ColorManager.blue,
    fontSize: 20,
  );
}
