import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/shared_preferences/favorite_save.dart';
import 'package:advanced_app/features/Favorite/data/models/favorite_model/favorite_model.dart';
import 'package:advanced_app/features/Favorite/presentation/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonDelete extends StatefulWidget {
  const ButtonDelete({
    super.key,
    required this.favoriteId,
    required this.index,
    required this.listFavorite,
  });
  final FavoriteModel favoriteId;
  final int index;
  final List<FavoriteModel> listFavorite;

  @override
  State<ButtonDelete> createState() => _ButtonDeleteState();
}

class _ButtonDeleteState extends State<ButtonDelete> {
  final FavoriteManager _favoriteManager =
      FavoriteManager(); // إنشاء كائن من FavoriteManager

  final FavoritesService _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),

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
      child:
          BlocBuilder<FavoriteCubit, FavoriteState>(builder: (context, state) {
        return IconButton(
            onPressed: () {
              context.read<FavoriteCubit>().deleteFavorite(
                  widget.favoriteId.products!.productId.toString());

              //! delete for cash

              _favoritesService.deleteFavorite(
                widget.favoriteId.products!.productId.toString(),
              );

              _favoriteManager.toggleFavorite();
            },
            icon: const Icon(
              Icons.delete_forever,
              color: ColorManager.red,
            ));
      }),
    );
  }
}
