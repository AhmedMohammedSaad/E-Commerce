part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

//! get Cart
class GetCartLoding extends CartState {}

class GetCartSuccses extends CartState {}

class GetCartError extends CartState {
  final String error;

  const GetCartError({required this.error});
  @override
  List<Object> get props => [error];
}

//! Delete Cart
class DeleteCartLoding extends CartState {}

class DeleteCartSuccses extends CartState {}

class DeleteCartError extends CartState {
  final String error;

  const DeleteCartError({required this.error});
  @override
  List<Object> get props => [error];
}

//! add and delete counter
class CounterNumberAdd extends CartState {}

class CounterDelete extends CartState {}

//! post products for user_detalse_purtchease
class PostProductToDataBaseSuccess extends CartState {}

class PostProductToDataBaseLoading extends CartState {}

class PostProductToDataBaseError extends CartState {
  final String error;
  const PostProductToDataBaseError({required this.error});
  @override
  List<Object> get props => [error];
}

//! Update Quantity
class QuantityUpdated extends CartState {}
