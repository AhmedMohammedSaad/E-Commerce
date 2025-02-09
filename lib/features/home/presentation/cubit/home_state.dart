part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

//! Advertisements
final class AdvertisementsLoading extends HomeState {}

final class AdvertisementsSuccses extends HomeState {}

final class AdvertisementsFailure extends HomeState {
  final String error;
  const AdvertisementsFailure({required this.error});
}

//! SaleHome
final class SaleHomeLoading extends HomeState {}

final class SaleHomeSuccses extends HomeState {}

final class SaleHomeFailure extends HomeState {
  final String error;
  const SaleHomeFailure({required this.error});
}
