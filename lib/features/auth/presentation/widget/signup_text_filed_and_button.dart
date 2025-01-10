import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldandButtonSignup extends StatelessWidget {
  const TextFieldandButtonSignup({
    super.key,
    required this.controllerName,
    required this.controllerGemail,
    required this.controllerPassword,
  });

  final TextEditingController controllerName;
  final TextEditingController controllerGemail;
  final TextEditingController controllerPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 15.h,
        children: [
          TextFiealdApp(
            controller: controllerName,
            hintText: 'Name',
          ),
          TextFiealdApp(
            controller: controllerGemail,
            hintText: 'Gmail',
          ),
          TextFiealdPassword(
            controller: controllerPassword,
            hintText: 'Password',
          ),
        ],
      ),
    );
  }
}
