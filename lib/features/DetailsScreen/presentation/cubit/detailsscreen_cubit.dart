import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/core/api/stringes_for_api.dart';
import 'package:advanced_app/features/DetailsScreen/data/models/comments/comments.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'detailsscreen_state.dart';

class DetailsscreenCubit extends Cubit<DetailsscreenState> {
  DetailsscreenCubit({required this.apiConsumer}) : super(DetailsscreenInitial());
  final userID = Supabase.instance.client.auth.currentUser!.id;
  //! dio
  final ApiConsumer apiConsumer;
  //! List of data
  List<Comments> commentsList = [];
  //! function get comment from api

  Future getComments(id) async {
    emit(CommentLoading());
    try {
      final response = await apiConsumer.get(Endpoint.getComment(id));
      for (var data in response) {
        commentsList.add(Comments.fromJson(data));
      }
      emit(CommentSuccses());
    } on ApiExceptions catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  //! add rating and comment
  addComment({required String productID, required String comment}) async {
    emit(AddCommentesLoading());
    try {
      //! comments
      await apiConsumer
          .post("comments", data: {"comment": comment, "for_user_id": userID, "for_product_id": productID});

      emit(AddCommentesSuccses());
    } on ApiExceptions catch (e) {
      emit(AddCommentesError(e.apiExceptions.message));
    }
  }

  addRating({
    required int ratNum,
    required String productID,
  }) async {
    emit(AddRatLoading());
    try {
      //! rating
      await apiConsumer
          .post("rating", data: {"rating_num": ratNum, "for_user_id": userID, "for_producte_id": productID});

      emit(AddRatSuccses());
    } on ApiExceptions catch (e) {
      emit(AddRatError(e.apiExceptions.message));
    }
  }

  // Future getComments(id) async {
  //   emit(CommentLoading());
  //   try {
  //     Response response = await _apiServices.getData(
  //         "products?product_id=eq.$id&select=product_id,comments(*,users(name))");
  //     if (response.statusCode == 200) {
  //       for (var comm in response.data) {
  //         commentsList.add(Comments.fromJson(comm));
  //       }
  //       emit(CommentSuccses());
  //     } else {
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     emit(
  //       CommentError(e.toString()),
  //     );
  //   }
  // }
}
