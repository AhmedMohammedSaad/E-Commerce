import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/features/Favorite/data/models/favorite_model/favorite_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({required this.apiConsumer}) : super(FavoriteInitial());
  //! id
  final String userId = Supabase.instance.client.auth.currentUser!.id;

//! instance from dio
  final ApiConsumer apiConsumer;
  //! list of facorite
  List<FavoriteModel> favorites = [];
  final SupabaseClient supabase = Supabase.instance.client;

  //! get favorite
  Future getFavorite() async {
    favorites = [];
    emit(FavoriteLoding());

    try {
      final response = await apiConsumer
          .get("favorte?for_user_id=eq.$userId&select=*,products(*)");

      for (var data in response) {
        favorites.add(FavoriteModel.fromJson(data));
      }

      emit(FavoriteSuccses());
    } on ApiExceptions catch (e) {
      emit(FavoriteError(error: e.toString()));
    }
  }

//! delete faivorite
  Future deleteFavorite(String pruductId) async {
    emit(DeleteFavoriteLoding());

    try {
      await apiConsumer.delete("favorte?for_product_id=eq.$pruductId");

      await getFavorite();
      emit(DeleteFavoriteSuccses());
    } on ApiExceptions catch (e) {
      emit(DeleteFavoriteError(error: e.apiExceptions.message));
    }
  }
}
