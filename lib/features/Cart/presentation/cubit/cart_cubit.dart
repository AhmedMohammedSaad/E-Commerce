import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.apiConsumer}) : super(CartInitial());
  final userId = Supabase.instance.client.auth.currentUser!.id;
  //!instanse from api
  final ApiConsumer apiConsumer;
  //! list of cart
  List<CartModel> carts = [];
  //! map to store quantities for each cart item
  Map<String, int> quantities = {};

  //! function get cart
  Future getCart() async {
    carts = [];
    emit(GetCartLoding());
    try {
      final response = await apiConsumer
          .get("cart?for_user_id=eq.$userId&select=*,products(*)");
      for (var elment in response) {
        final cartItem = CartModel.fromJson(elment);
        carts.add(cartItem);
        // Initialize quantity to 1 for each cart item
        quantities[cartItem.forProductId ?? ''] = 1;
      }
      emit(GetCartSuccses());
    } on ApiExceptions catch (e) {
      emit(GetCartError(error: e.apiExceptions.message));
    }
  }

  //! increment quantity
  void incrementQuantity(String productId) {
    if (quantities.containsKey(productId)) {
      quantities[productId] = (quantities[productId] ?? 1) + 1;
      emit(QuantityUpdated());
    }
  }

  //! decrement quantity
  void decrementQuantity(String productId) {
    if (quantities.containsKey(productId) && quantities[productId]! > 1) {
      quantities[productId] = quantities[productId]! - 1;
      emit(QuantityUpdated());
    }
  }

  //! get quantity for a product
  int getQuantity(String productId) {
    return quantities[productId] ?? 1;
  }

  //! calculate total price
  double calculateTotalPrice() {
    double total = 0;
    for (var cart in carts) {
      if (cart.products?.price != null && cart.forProductId != null) {
        int quantity = quantities[cart.forProductId] ?? 1;
        total += double.parse(cart.products!.price!) * quantity;
      }
    }
    return total;
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

//!   Post Product To DataBase
  Future postProductToDataBase({
    required String name,
    required String address,
    required String phone,
    required String detalsePluss,
  }) async {
    emit(PostProductToDataBaseLoading());
    try {
      final response = await apiConsumer
          .get("cart?for_user_id=eq.$userId&select=*,products(*)");
      await apiConsumer.post("user_detalse_purtchease", data: {
        "name": name,
        "address": address,
        "phone": phone,
        "detalse_pluss": detalsePluss,
        "for_user": userId,
        "for_product": null,
        "for_purtchease": null,
        "product_purtchease": response
      });
      emit(PostProductToDataBaseSuccess());
    } on ApiExceptions catch (e) {
      emit(PostProductToDataBaseError(error: e.apiExceptions.message));
    }
  }
}
