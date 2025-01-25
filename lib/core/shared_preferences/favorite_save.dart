import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _favoriteKeyPrefix = "favorite";

  // حفظ حالة الإعجاب
  Future<void> saveFavorite(String productId, bool isFavorite) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool("$_favoriteKeyPrefix$productId", isFavorite);
  }

  // جلب حالة الإعجاب
  Future<bool> getFavorite(String productId) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool("$_favoriteKeyPrefix$productId") ?? false;
  }

  // حذف حالة الإعجاب
  Future<void> deleteFavorite(String productId) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove("$_favoriteKeyPrefix$productId");
  }
}

class FavoriteManager {
  bool _favoriteBoll = false;

  bool get favoriteBoll => _favoriteBoll;

  void setFavorite(bool value) {
    _favoriteBoll = value;
  }

  void toggleFavorite() {
    _favoriteBoll = !_favoriteBoll;
  }
}
