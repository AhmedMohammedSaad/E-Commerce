// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/cubit/detailsscreen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';

Future<dynamic> addCommentAndRatingDialog(BuildContext context, productID) {
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
          BlocBuilder<DetailsscreenCubit, DetailsscreenState>(
              builder: (context, stat) {
            return TextButton(
              onPressed: () {
                // Handle the submit action here
                String comment = controller.text;
                context.read<DetailsscreenCubit>().addRateAndComment(
                    ratNum: rating.toInt(),
                    productID: productID,
                    comment: comment);

                Navigator.of(context).pop();
              },
              child: Text(
                'Submit',
                style: StyleTextApp.font20ColorManColor,
              ),
            );
          }),
        ],
      );
    },
  );
}
