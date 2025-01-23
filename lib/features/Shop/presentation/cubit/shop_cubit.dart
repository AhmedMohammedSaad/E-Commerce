import 'dart:developer';

import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/core/api/stringes_for_api.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit({required this.apiConsumer}) : super(ShopInitial());
  final ApiConsumer apiConsumer;
  // final ApiServices _apiServices = ApiServices();
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
}
