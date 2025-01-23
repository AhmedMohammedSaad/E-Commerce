import 'dart:developer';

import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/core/api/stringes_for_api.dart';
import 'package:advanced_app/features/home/data/models/advertisements/advertisements.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.apiConsumer}) : super(HomeInitial());
  final ApiConsumer apiConsumer;
  //! List of Advertisements
  List<Advertisements> advertisementsList = [];
  //! get data the Advertisements from api

  Future getAdvertisements() async {
    emit(AdvertisementsLoading());

    try {
      final response = await apiConsumer.get(Endpoint.getAdvertisements);

      for (var data in response) {
        advertisementsList.add(Advertisements.fromJson(data));
      }
      log(advertisementsList.toString());
      emit(AdvertisementsSuccses());
    } on ApiExceptions catch (e) {
      emit(AdvertisementsFailure(error: e.toString()));
    }
  }
}
