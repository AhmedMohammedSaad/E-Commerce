import 'package:advanced_app/core/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LodingApp extends StatelessWidget {
  const LodingApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.dotsTriangle(
        size: 90,
        color: ColorManager.green,
      ),
    );
  }
}
