// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';

Future<dynamic> addCommentAndRatingDialog(BuildContext context) {
  final TextEditingController controller = TextEditingController();
  double rating = 0;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorManager.white,
        title: Text(
          'Add Comment and Rating',
          style: StyleTextApp.font14ColorblacFontWeightBold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFiealdApp(
              controller: controller,
              hintText: "Add Comments",
            ),
            const SizedBox(height: 20),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 3),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                rating = newRating;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: StyleTextApp.font14ColorblacFontWeightBold,
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle the submit action here
              String comment = controller.text;
              print('Comment: $comment');
              print('Rating: ${rating.toInt()}');
              Navigator.of(context).pop();
            },
            child: Text(
              'Submit',
              style: StyleTextApp.font20ColorManColor,
            ),
          ),
        ],
      );
    },
  );
}
