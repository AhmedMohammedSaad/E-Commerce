import 'package:advanced_app/core/color/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageProductDetalse extends StatelessWidget {
  const ImageProductDetalse({
    super.key,
    required this.products,
  });
  // ignore: prefer_typing_uninitialized_variables
  final products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: products.imageUrl.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  height: 185.h,
                  width: 200.w,
                  child: Card(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 90,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )),
      ),
    );
  }
}
