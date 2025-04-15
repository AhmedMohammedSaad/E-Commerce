import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  final supabase = Supabase.instance.client;

  Future<void> getAdvertisements() async {
    emit(GetAdvertisementsLoading());
    try {
      final response = await supabase
          .from('advertisements')
          .select()
          .order('created_at', ascending: false);

      emit(GetAdvertisementsSuccess(response));
    } catch (e) {
      emit(GetAdvertisementsFailure(e.toString()));
    }
  }

  Future<void> addAdvertisement({
    required String titleName,
    required String description,
    required String imageUrl,
  }) async {
    emit(AddAdvertisementLoading());
    try {
      await supabase
          .from('advertisements')
          .insert({
            'title_name': titleName,
            'descreption': description,
            'image_url': imageUrl,
          })
          .select()
          .single();

      await getAdvertisements(); // Refresh the list
      emit(AddAdvertisementSuccess());
    } catch (e) {
      emit(AddAdvertisementFailure(e.toString()));
    }
  }

  Future<void> updateAdvertisement({
    required String id,
    required String titleName,
    required String description,
    required String imageUrl,
  }) async {
    emit(UpdateAdvertisementLoading());
    try {
      await supabase
          .from('advertisements')
          .update({
            'title_name': titleName,
            'descreption': description,
            'image_url': imageUrl,
          })
          .eq('id', id)
          .select()
          .single();

      await getAdvertisements(); // Refresh the list
      emit(UpdateAdvertisementSuccess());
    } catch (e) {
      emit(UpdateAdvertisementFailure(e.toString()));
    }
  }

  Future<void> deleteAdvertisement(String id) async {
    emit(DeleteAdvertisementLoading());
    try {
      await supabase.from('advertisements').delete().eq('id', id);

      await getAdvertisements(); // Refresh the list
      emit(DeleteAdvertisementSuccess());
    } catch (e) {
      emit(DeleteAdvertisementFailure(e.toString()));
    }
  }
}
