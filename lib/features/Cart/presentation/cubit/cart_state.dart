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
}

//! Delete Cart
class DeleteCartLoding extends CartState {}

class DeleteCartSuccses extends CartState {}

class DeleteCartError extends CartState {
  final String error;

  const DeleteCartError({required this.error});
}
