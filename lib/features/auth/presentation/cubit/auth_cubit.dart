import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
//! supabase instance client
  final SupabaseClient supabase = Supabase.instance.client;

//! get token Function

  Future<String?> getToken() async {
    final session = supabase.auth.currentSession;
    log(session?.accessToken ?? 'No token available');
    return session?.accessToken;
  }

  //! login Function
  Future login(final String email, final String password) async {
    emit(LoginLoading());
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
      getToken();
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

//! sign up Function
  Future signup(final String email, final String password) async {
    emit(SignUpLoading());
    try {
      await supabase.auth.signUp(email: email, password: password);
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      emit(SignUpFailure(e.message));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  // //! verify email
  // Future verigyEmail(
  //   final String email,
  // ) async {
  //   emit(VerifyEmailLoading());
  //   try {
  //     emit(VerifyEmailSuccess());
  //     await supabase.auth.verifyOTP(
  //       type: OtpType.email,
  //       token:
  //           'eyJhbGciOiJIUzI1NiIsImtpZCI6IlFuSERCWktFUXl4cEMxc3UiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3V2ZWRlamF0eGVvaWVxeXN4a2JjLnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJzdWIiOiI2YWQ2MzVhYy1hMzAzLTRmNDEtYWFkNS0zODExYTVmZDI3MGEiLCJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzM2NTA0NzgzLCJpYXQiOjE3MzY1MDExODMsImVtYWlsIjoiYWhtZWRhbGxtcGUxMkBnbWFpbC5jb20iLCJwaG9uZSI6IiIsImFwcF9tZXRhZGF0YSI6eyJwcm92aWRlciI6ImVtYWlsIiwicHJvdmlkZXJzIjpbImVtYWlsIl19LCJ1c2VyX21ldGFkYXRhIjp7ImVtYWlsX3ZlcmlmaWVkIjp0cnVlfSwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJhYWwiOiJhYWwxIiwiYW1yIjpbeyJtZXRob2QiOiJwYXNzd29yZCIsInRpbWVzdGFtcCI6MTczNjQyMTI5MX1dLCJzZXNzaW9uX2lkIjoiNTU2ZDk0YzItMWY5ZC00ZjgyLThjODgtNzQ0YWY1NGE2YWRmIiwiaXNfYW5vbnltb3VzIjpmYWxzZX0.902VbaWX7HIZMYOnYF1EB_3T8yK4MyOiaYEYgZkw1js',
  //       email: email,
  //     );
  //   } on AuthException catch (e) {
  //     emit(VerifyEmailFailure(e.message));
  //   } catch (e) {
  //     emit(VerifyEmailFailure(e.toString()));
  //   }
  // }
}
