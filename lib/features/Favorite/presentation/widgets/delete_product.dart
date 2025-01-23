import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Favorite/data/models/favorite/products.dart';
import 'package:advanced_app/features/Favorite/presentation/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonDelete extends StatelessWidget {
  const ButtonDelete({
    super.key,
    required this.favoriteId,
  });
  final Products favoriteId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      // alignment: Alignment.center,
      // height: 30.h,
      // width: 46.w,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(51, 0, 0, 0),
            spreadRadius: 2,
            offset: Offset(5, 2),
            blurRadius: 10,
          ),
        ],
        color: const Color.fromARGB(170, 255, 255, 255),
        borderRadius: BorderRadius.circular(14.r),
      ),
      //!delete button
      child: IconButton(
          onPressed: () {
            context.read<FavoriteCubit>().deleteFavorte(favoriteId.productId);
          },
          icon: const Icon(
            Icons.delete_forever,
            color: ColorManager.red,
          )),
    );
  }
}
