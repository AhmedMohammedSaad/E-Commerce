import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        ).animate().fadeIn(duration: 600.ms).then(delay: 200.ms).slide(
              begin: const Offset(1.0, 1.0), // Start from the right
              end: Offset.zero, // End at the original position
              duration: 800.ms,
            ),
        TextFiealdPassword(
          controller: controllerPassword,
          hintText: 'Password',
        ).animate().fadeIn(duration: 600.ms).then(delay: 200.ms).slide(
              begin: const Offset(-1.0, -1.0), // Start from the right
              end: Offset.zero, // End at the original position
              duration: 800.ms,
            ),
        BottonAPP(
          onTap: () {},
          nameBotton: 'Log In',
          colorBotton: ColorManager.green,
          colorText: ColorManager.white,
          width: double.infinity.w,
        )
            .animate()
            .then(duration: 1000.ms) // تأخير قبل العودة
            .fadeIn(duration: 1000.ms),
      ],
    );
  }
}
