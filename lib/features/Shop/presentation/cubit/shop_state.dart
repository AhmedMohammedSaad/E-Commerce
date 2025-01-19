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
