import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/features/Favorite/data/models/favorite/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({required this.apiConsumer}) : super(FavoriteInitial());
//! instance from dio
  final ApiConsumer apiConsumer;
  //! list of facorite
  final List<FavoriteModel> favorites = [];
  //! get favorite
  Future getFavorite() async {
    emit(FavoriteLoding());
    try {
      final response = await apiConsumer.get("favorte?select=*,products(*)");
      for (var data in response) {
        favorites.add(FavoriteModel.fromJson(data));
      }

      emit(FavoriteSuccses());
      return response;
    } on ApiExceptions catch (e) {
      emit(FavoriteError(error: e.toString()));
    }
  }

  //! delete
  Future deleteFavorte(id) async {
    emit(DeleteFavoriteLoding());
    print("looooooooooooooding");
    try {
      await apiConsumer.delete("favorte?favorte_id=eq.$id");
      print("succccccccccccccccses");

      emit(DeleteFavoriteSuccses());
    } on ApiExceptions catch (e) {
      emit(DeleteFavoriteError(error: e.toString()));
    }
  }
}
