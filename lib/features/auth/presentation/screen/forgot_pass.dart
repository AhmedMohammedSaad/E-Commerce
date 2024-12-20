// ignore_for_file: prefer_const_constructors
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/botton.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget {
  ForgotPass({super.key});
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
                "Forgot",
                style: StyleTextApp.font24ColorblacColorFontWeightBolde,
              ),
              TextFiealdApp(
                controller: controller,
                hintText: "Gmail",
              ),
              BottonAPP(
                  onTap: () {
                    Navigator.pushNamed(context, '/newPass');
                  },
                  nameBotton: 'Send Gmail',
                  colorBotton: ColorManager.green,
                  colorText: ColorManager.white,
                  width: double.infinity)
            ],
          ),
        ),
      ),
    );
  }
}
