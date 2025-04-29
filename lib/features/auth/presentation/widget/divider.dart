// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:flutter/material.dart';

class DividerOR extends StatelessWidget {
  const DividerOR({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey, // Color of the divider
            thickness: 1, // Thickness of the divider
            endIndent: 8.0, // Space between the divider and the text
          ),
        ),
        Text(
          "OR", // Text to display
          style: TextStyle(
            // Text style
            fontSize: 16.0, // Adjust font size
            fontWeight: FontWeight.bold, // Optional: bold text
            color: AppColors.primaryColor, // Optional: text color
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey, // Color of the divider
            thickness: 1, // Thickness of the divider
            indent: 8.0, // Space between the divider and the text
          ),
        ),
      ],
    );
  }
}
