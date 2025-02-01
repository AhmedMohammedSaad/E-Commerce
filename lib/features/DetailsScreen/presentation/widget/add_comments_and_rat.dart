// ignore_for_file: prefer_const_constructors

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/cubit/detailsscreen_cubit.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';

Future<dynamic> addCommentAndRatingDialog(
    BuildContext context, ProductsShop productID) {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
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
        content: Form(
          key: key,
          child: Column(
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
          BlocProvider(
            create: (BuildContext context) =>
                DetailsscreenCubit(apiConsumer: DioConsumer()),
            child: BlocBuilder<DetailsscreenCubit, DetailsscreenState>(
                builder: (context, stat) {
              return stat is AddCommentesLoading
                  ? CircularProgressIndicator(
                      strokeWidth: 3,
                      color: ColorManager.green,
                    )
                  : TextButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          // Handle the submit action here
                          context.read<DetailsscreenCubit>().addComment(
                                productID: productID.productId.toString(),
                                comment: controller.text,
                              );
                          context.read<DetailsscreenCubit>().addRating(
                                productID: productID.productId.toString(),
                                ratNum: rating.toInt(),
                              );
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Submit',
                        style: StyleTextApp.font20ColorManColor,
                      ),
                    );
            }),
          ),
        ],
      );
    },
  );
}
