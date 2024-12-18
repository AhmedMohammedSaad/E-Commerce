// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/StringImage/string_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginWhitheGoogleandFaceBook extends StatelessWidget {
  const LoginWhitheGoogleandFaceBook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Login with Google
        Container(
          width: double.infinity,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Colors.white, // Background color
            border: Border.all(color: Colors.grey), // Border color
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/googleIcon.svg',
                width: 10,
              ),
              SizedBox(width: 8), // Space between icon and text
              Text(
                "Login with Google",
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 14, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16), // Space between buttons

        //! Login with Facebook
        Container(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Colors.white, // Background color
            border: Border.all(color: Colors.grey), // Border color
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.facebook, // Facebook icon
                color: Colors.blue,
                size: 18,
              ),
              SizedBox(width: 8), // Space between icon and text
              Text(
                "Login with Facebook",
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 14, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
