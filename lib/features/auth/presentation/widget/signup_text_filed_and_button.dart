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
          ).animate().fadeIn(duration: 600.ms).then(delay: 200.ms).slide(
                begin: const Offset(-1.0, 0.0), // Start from the right
                end: Offset.zero, // End at the original position
                duration: 800.ms,
              ),
          TextFiealdApp(
            controller: controllerGemail,
            hintText: 'Gmail',
          ).animate().fadeIn(duration: 600.ms).then(delay: 200.ms).slide(
                begin: const Offset(1.0, 0.0), // Start from the right
                end: Offset.zero, // End at the original position
                duration: 800.ms,
              ),
          TextFiealdPassword(
            controller: controllerPassword,
            hintText: 'Password',
          ).animate().fadeIn(duration: 600.ms).then(delay: 200.ms).slide(
                begin: const Offset(-1.0, 0.0), // Start from the right
                end: Offset.zero, // End at the original position
                duration: 800.ms,
              ),
          BottonAPP(
            onTap: () {},
            nameBotton: 'Sign UP',
            colorBotton: ColorManager.green,
            colorText: ColorManager.white,
            width: double.infinity.w,
          )
              .animate()
              .then(duration: 1000.ms) // تأخير قبل العودة
              .fadeIn(duration: 1000.ms), // الظهور التدريجي
        ],
      ),
    );
  }
}
