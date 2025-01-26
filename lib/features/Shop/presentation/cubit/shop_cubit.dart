import 'dart:developer';

import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/core/api/stringes_for_api.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/column_image_name_shopicon.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit({required this.apiConsumer}) : super(ShopInitial());
  final ApiConsumer apiConsumer;
  final String userId = Supabase.instance.client.auth.currentUser!.id;
  //! List of Product
  List<ProductsShop> getProductsData = [];
  //! get data the SaleHome from api

  Future getProducts() async {
    emit(ShopingLoading());

    try {
      final response = await apiConsumer.get(Endpoint.getProduct);
      for (var res in response) {
        getProductsData.add(ProductsShop.fromJson(res));
      }
      emit(ShopingSuccses());
    } on ApiExceptions catch (e) {
      emit(ShopingFailure(error: e.toString()));
      log(e.toString());
    }
  }

  Map<String, bool> isFavorte = {};
//! add faivorite
  Future addFavorite(String productId) async {
    emit(AddFaforiteLoading());

    try {
      await apiConsumer.post("favorte", data: {
        "bool": true,
        "for_user_id": userId,
        "for_product_id": productId,
      });
      isFavorte.addAll({
        productId: true,
      });

      emit(AddFaforiteSuccses());
    } on ApiExceptions catch (e) {
      emit(AddFaforiteFailure(error: e.apiExceptions.message));
      log(e.apiExceptions.message);
    }
  }

//! delete faivorite
  Future deleteFavorite(String productId) async {
    emit(DeleteFaforiteLoading());

    try {
      await apiConsumer.delete("favorte?for_product_id=eq.$productId");
      isFavorte.remove(productId);

      emit(DeleteFaforiteSuccses());
    } on ApiExceptions catch (e) {
      emit(DeleteFaforiteFailure(error: e.apiExceptions.message));
      log(e.apiExceptions.message);
    }
  }

  bool chaickIsFavorte(productId) {
    return isFavorte.containsKey(productId);
  }

  //! add to cart
  Future addToCart(String productId) async {
    emit(AddToCartLoading());

    try {
      await apiConsumer.post("cart", data: {
        "is_cart": true,
        "for_user_id": userId,
        "for_product_id": productId,
      });

      emit(AddToCartSuccses());
    } on ApiExceptions catch (e) {
      emit(AddToCartFailure(error: e.apiExceptions.message));
      log(e.apiExceptions.message);
    }
  }
}
//! search products
