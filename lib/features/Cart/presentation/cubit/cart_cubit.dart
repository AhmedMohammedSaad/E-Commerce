import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.apiConsumer) : super(CartInitial());
  final userId = Supabase.instance.client.auth.currentUser!.id;
  //!instanse from api
  final ApiConsumer apiConsumer;
  //! list of cart
  List<CartModel> carts = [];
  //! function get cart
  Future getCart() async {
    carts = [];
    emit(GetCartLoding());
    try {
      final response = await apiConsumer
          .get("cart?for_user_id=eq.$userId&select=*,products(*)");
      for (var elment in response) {
        carts.add(CartModel.fromJson(elment));
      }
      emit(GetCartSuccses());
    } on ApiExceptions catch (e) {
      emit(GetCartError(error: e.apiExceptions.message));
    }
  }

//! delete cart
  Future deleteCart(String pruductId) async {
    emit(DeleteCartLoding());

    try {
      await apiConsumer.delete("cart?for_product_id=eq.$pruductId");

      await getCart();
      emit(DeleteCartSuccses());
    } on ApiExceptions catch (e) {
      emit(DeleteCartError(error: e.apiExceptions.message));
    }
  }
}
