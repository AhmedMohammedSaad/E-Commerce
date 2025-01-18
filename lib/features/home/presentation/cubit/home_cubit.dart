import 'dart:developer';

import 'package:advanced_app/core/api/method_for_api.dart';
import 'package:advanced_app/features/home/data/models/advertisements/advertisements.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  //! instance of ApiServices
  final ApiServices _apiServices = ApiServices();
  //! List of Advertisements
  List<Advertisements> advertisementsList = [];
  //! get data the Advertisements from api

  Future getAdvertisements() async {
    emit(AdvertisementsLoading());
    try {
      final response = await _apiServices.getData("advertisements");
      if (response.statusCode == 200) {
        // log(response.data.toString());
        for (var item in response.data) {
          advertisementsList.add(Advertisements.fromJson(item));
        }
        emit(AdvertisementsSuccses());
      } else {
        emit(AdvertisementsFailure(error: response.statusMessage.toString()));
      }
    } catch (e) {
      emit(AdvertisementsFailure(error: e.toString()));
    }
  }
}
