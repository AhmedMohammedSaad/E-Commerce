part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

//! the 3 state for login
final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String error;

  const LoginFailure(this.error);
}

//! the 3 state for sign up
final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {}

final class SignUpFailure extends AuthState {
  final String error;

  const SignUpFailure(this.error);
}

//! the 3 state for verify email
final class VerifyEmailLoading extends AuthState {}

final class VerifyEmailSuccess extends AuthState {}

final class VerifyEmailFailure extends AuthState {
  final String error;

  const VerifyEmailFailure(this.error);
}

//! the 3 state for Signin with google
final class SignInWithGoogleLoading extends AuthState {}

final class SignInWithGoogleSuccess extends AuthState {}

final class SignInWithGoogleFailure extends AuthState {
  final String error;

  const SignInWithGoogleFailure(this.error);
}

//! Reset Password
final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordFailure extends AuthState {
  final String error;

  const ResetPasswordFailure(this.error);
}

//! the 3 state for add data for user
final class AddDataUserLoading extends AuthState {}

final class AddDataUserSuccess extends AuthState {}

final class AddDataUserFailure extends AuthState {
  final String error;

  const AddDataUserFailure(this.error);
}
