import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/get_data_user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

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
}
