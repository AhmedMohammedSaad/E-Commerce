import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldandButtonLogin extends StatelessWidget {
  const TextFieldandButtonLogin({
    super.key,
    required this.controllerGemail,
    required this.controllerPassword,
  });

  final TextEditingController controllerGemail;
  final TextEditingController controllerPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15.h,
      children: [
        // Text FiealdApp
        TextFiealdApp(
          controller: controllerGemail,
          hintText: 'UserName', // Hint text
        ),
        TextFiealdPassword(
          controller: controllerPassword, // Controller
          hintText: 'Password',
        ),
      ],
    );
  }
}
