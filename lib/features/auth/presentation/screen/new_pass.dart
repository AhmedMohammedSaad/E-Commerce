// ignore_for_file: prefer_const_constructors
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NewPass extends StatelessWidget {
  NewPass({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            spacing: 100,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "add_new_password".tr(),
                style: StyleTextApp.font24ColorblacColorFontWeightBolde,
              ),
              TextFiealdApp(
                controller: controller,
                hintText: "new_password".tr(),
              ),
              BottonAPP(
                  nameBotton: 'new_password_button'.tr(),
                  colorBotton: AppColors.primaryColor,
                  colorText: AppColors.white,
                  width: double.infinity)
            ],
          ),
        ),
      ),
    );
  }
}
