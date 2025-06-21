// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';

class TextFiealdApp extends StatelessWidget {
  const TextFiealdApp({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIconColor: AppColors.primaryColor,
        hintText: hintText,
        hintStyle: StyleTextApp.font14Colorgrayofwite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This Field is required';
        } else {
          return null;
        }
      },
    );
  }
}

//! Text Form Feild for Password
class TextFiealdPassword extends StatefulWidget {
  const TextFiealdPassword({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final Icon? suffixIcon;

  @override
  State<TextFiealdPassword> createState() => _TextFiealdPasswordState();
}

class _TextFiealdPasswordState extends State<TextFiealdPassword> {
  bool icon = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: icon,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              icon = !icon;
            });
          },
          icon: icon ? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined),
        ),
        suffixIconColor: AppColors.primaryColor,
        hintText: widget.hintText,
        hintStyle: StyleTextApp.font14Colorgrayofwite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This Field is required';
        } else {
          return null;
        }
      },
    );
  }
}
