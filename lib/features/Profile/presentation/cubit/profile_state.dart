part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

//! the 3 state for get data useer

final class GetDataUserLoading extends ProfileState {}

// ignore: must_be_immutable
final class GetDataUserSuccess extends ProfileState {}

final class GetDataUserFailure extends ProfileState {
  final String error;

  const GetDataUserFailure(this.error);
}
