import 'dart:developer';

import 'package:advanced_app/core/api/method_for_api.dart';
import 'package:advanced_app/features/DetailsScreen/data/models/comments/comments.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'detailsscreen_state.dart';

class DetailsscreenCubit extends Cubit<DetailsscreenState> {
  DetailsscreenCubit() : super(DetailsscreenInitial());
  //! dio
  final ApiServices _apiServices = ApiServices();
  //! List of data
  List<Comments> commentsList = [];
  //! function get comment from api
  Future getComments(id) async {
    emit(CommentLoading());
    try {
      Response response = await _apiServices.getData(
          "products?product_id=eq.$id&select=product_id,comments(*,users(name))");
      if (response.statusCode == 200) {
        for (var comm in response.data) {
          commentsList.add(Comments.fromJson(comm));
        }
        emit(CommentSuccses());
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
      emit(
        CommentError(e.toString()),
      );
    }
  }
}
