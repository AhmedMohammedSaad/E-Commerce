part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

//! get facorite state
class FavoriteLoding extends FavoriteState {}

class FavoriteSuccses extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String error;

  const FavoriteError({required this.error});
}

//! delete facorite state
class DeleteFavoriteLoding extends FavoriteState {}

class DeleteFavoriteSuccses extends FavoriteState {}

class DeleteFavoriteError extends FavoriteState {
  final String error;

  const DeleteFavoriteError({required this.error});
}
