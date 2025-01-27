import 'dart:developer';

import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/get_data_user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.apiConsumer}) : super(ProfileInitial());
  //! id
  final String userId = Supabase.instance.client.auth.currentUser!.id;
  final ApiConsumer apiConsumer;
  final supabase = Supabase.instance.client;
  GetDataUser? getDataUserModel;
  //! get data user

  Future<void> getDataUser() async {
    emit(GetDataUserLoading());
    try {
      final data = await supabase.from('users').select().eq(
            'user_id',
            supabase.auth.currentUser!.id,
          );
      getDataUserModel = GetDataUser.fromJson(data[0]);
      // GetDataUser.fromJson(data[0]);

      emit(GetDataUserSuccess());
    } catch (e) {
      emit(GetDataUserFailure(
        e.toString(),
      ));
    }
  }

  //! delete all favorite and cart
  Future deleteAllFavorite() async {
    try {
      await apiConsumer.delete("favorte?for_user_id=eq.$userId&select=*");
    } on ApiExceptions catch (e) {
      log(e.apiExceptions.message);
    }
  }

  Future deleteAllCart() async {
    try {
      await apiConsumer.delete("cart?for_user_id=eq.$userId&select=*");
    } on ApiExceptions catch (e) {
      log(e.apiExceptions.message);
    }
  }
}
