part of 'shop_cubit.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

//! Shoping
final class ShopingLoading extends ShopState {}

final class ShopingSuccses extends ShopState {}

final class ShopingFailure extends ShopState {
  final String error;
  const ShopingFailure({required this.error});
}

//! add favorite
final class AddFaforiteLoading extends ShopState {}

final class AddFaforiteSuccses extends ShopState {}

final class AddFaforiteFailure extends ShopState {
  final String error;
  const AddFaforiteFailure({required this.error});
}

//! Delete favorite
final class DeleteFaforiteLoading extends ShopState {}

final class DeleteFaforiteSuccses extends ShopState {}

final class DeleteFaforiteFailure extends ShopState {
  final String error;
  const DeleteFaforiteFailure({required this.error});
}

//! add to cart
final class AddToCartLoading extends ShopState {}

final class AddToCartSuccses extends ShopState {}

final class AddToCartFailure extends ShopState {
  final String error;
  const AddToCartFailure({required this.error});
}
