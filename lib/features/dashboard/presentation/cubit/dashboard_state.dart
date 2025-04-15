part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

// Get Advertisements States
class GetAdvertisementsLoading extends DashboardState {}

class GetAdvertisementsSuccess extends DashboardState {
  final List<Map<String, dynamic>> advertisements;
  const GetAdvertisementsSuccess(this.advertisements);

  @override
  List<Object> get props => [advertisements];
}

class GetAdvertisementsFailure extends DashboardState {
  final String error;
  const GetAdvertisementsFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Add Advertisement States
class AddAdvertisementLoading extends DashboardState {}

class AddAdvertisementSuccess extends DashboardState {}

class AddAdvertisementFailure extends DashboardState {
  final String error;
  const AddAdvertisementFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Update Advertisement States
class UpdateAdvertisementLoading extends DashboardState {}

class UpdateAdvertisementSuccess extends DashboardState {}

class UpdateAdvertisementFailure extends DashboardState {
  final String error;
  const UpdateAdvertisementFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Delete Advertisement States
class DeleteAdvertisementLoading extends DashboardState {}

class DeleteAdvertisementSuccess extends DashboardState {}

class DeleteAdvertisementFailure extends DashboardState {
  final String error;
  const DeleteAdvertisementFailure(this.error);

  @override
  List<Object> get props => [error];
}
