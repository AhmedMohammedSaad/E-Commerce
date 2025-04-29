// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on AuthException catch (e) {
      emit(LoginFailure(e.message));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

//! sign up Function
  Future signup(
      final String name, final String email, final String password) async {
    emit(SignUpLoading());
    try {
      await supabase.auth.signUp(email: email, password: password);
      addDataUser(name: name, email: email);
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      emit(SignUpFailure(e.message));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  GoogleSignInAccount? googleUser;
  //! Sign in with Google
  Future<AuthResponse> nativeGoogleSignIn() async {
    emit(SignInWithGoogleLoading());
    const webClientId =
        '188319356517-cee62pbmpjngeo85bkkbug4257vkhd5v.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      // clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(SignInWithGoogleFailure('No Access Token found.'));
    }

    AuthResponse authResponse = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken.toString(),
      accessToken: accessToken,
    );
    addDataUser(name: googleUser.displayName!, email: googleUser.email);
    emit(SignInWithGoogleSuccess());
    return authResponse;
  }

  //! Reset password
  Future resetPassword(String email) async {
    emit(ResetPasswordLoading());
    try {
      await supabase.auth.resetPasswordForEmail(email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }

  //! Add data for user
  Future addDataUser({required String name, required String email}) async {
    emit(AddDataUserLoading());
    try {
      await supabase.from('users').upsert({
        "user_id": supabase.auth.currentUser!.id,
        "name": name,
        "email": email,
      });
      emit(AddDataUserSuccess());
    } catch (e) {
      emit(AddDataUserFailure(e.toString()));
    }
  }
}
