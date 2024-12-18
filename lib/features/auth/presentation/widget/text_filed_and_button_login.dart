import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
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
        TextFiealdApp(
          controller: controllerGemail,
          hintText: 'UserName',
        ),
        TextFiealdPassword(
          controller: controllerPassword,
          hintText: 'Password',
        ),
        BottonAPP(
          onTap: () {},
          nameBotton: 'Log In',
          colorBotton: ColorManager.green,
          colorText: ColorManager.white,
          width: double.infinity.w,
        ),
        //! Forgot Password ?
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot password?",
                style: StyleTextApp.font13ColorManColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
