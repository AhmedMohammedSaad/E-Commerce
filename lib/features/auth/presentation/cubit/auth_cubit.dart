import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
//! supabase instance client
  final SupabaseClient supabase = Supabase.instance.client;
  //! login Function
  Future login(final String email, final String password) async {
    emit(LoginLoading());
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      emit(LoginSuccess());
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
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

  //!
  Future<void> signInWithFacebook() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: kIsWeb
            ? null
            : 'my.scheme://my-host', // Optionally set the redirect link to bring back the user via deeplink.
        authScreenLaunchMode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode
                .externalApplication, // Launch the auth screen in a new webview on mobile.
      );
      emit(LoginSuccess());
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
