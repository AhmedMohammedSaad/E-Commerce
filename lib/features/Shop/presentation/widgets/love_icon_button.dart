import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/shared_preferences/favorite_save.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoveIconButton extends StatefulWidget {
  const LoveIconButton({
    super.key,
    required this.index,
    required this.getProductData,
    this.onTap,
    required this.isFavorte,
  });

  final Function()? onTap;
  final int index;
  final ProductsShop getProductData;
  final bool isFavorte;

  @override
  State<LoveIconButton> createState() => _LoveIconButtonState();
}

class _LoveIconButtonState extends State<LoveIconButton> {
  final FavoritesService _favoriteService =
      FavoritesService(); // إنشاء كائن من FavoriteService
  final FavoriteManager _favoriteManager =
      FavoriteManager(); // إنشاء كائن من FavoriteManager

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  // جلب حالة الإعجاب عند بدء التشغيل
  Future<void> _loadFavoriteState() async {
    final isFavorite = await _favoriteService
        .getFavorite(widget.getProductData.productId.toString());
    _favoriteManager.setFavorite(isFavorite);
    setState(() {}); // تحديث الواجهة
  }

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
        onPressed: () async {
          final id = widget.getProductData.productId;

          if (_favoriteManager.favoriteBoll) {
            context.read<ShopCubit>().deleteFavorite(id.toString());
            await _favoriteService.deleteFavorite(id.toString()); // حذف الإعجاب
          } else {
            context.read<ShopCubit>().addFavorite(id.toString());
          }

          _favoriteManager.toggleFavorite(); // تغيير حالة الإعجاب

          // حفظ الحالة بعد التغيير
          await _favoriteService.saveFavorite(
              id.toString(), _favoriteManager.favoriteBoll);
        },
        icon: _favoriteManager.favoriteBoll
            ? const Icon(Icons.favorite, color: ColorManager.red)
            : const Icon(Icons.favorite_border),
      ),
    );
  }
}
