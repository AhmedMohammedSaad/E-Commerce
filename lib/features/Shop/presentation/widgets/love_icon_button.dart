// ignore_for_file: file_names

import 'package:advanced_app/core/color/colors.dart';
import 'package:flutter/material.dart';

class LoveIconButton extends StatelessWidget {
  const LoveIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(71, 0, 0, 0),
            spreadRadius: 2,
            offset: Offset(5, 5),
            blurRadius: 10,
          ),
        ],
        color: ColorManager.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border),
      ),
    );
  }
}
