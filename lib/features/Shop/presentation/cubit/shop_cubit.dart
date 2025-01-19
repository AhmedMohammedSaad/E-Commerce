import 'dart:developer';

import 'package:advanced_app/core/api/method_for_api.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  final ApiServices _apiServices = ApiServices();
  //! List of Product
  List<ProductsShop> getProductsData = [];
  //! get data the SaleHome from api
  Future getProducts() async {
    emit(ShopingLoading());
    try {
      final response =
          await _apiServices.getData("products?select=*,favorte(*),rating(*)");
      if (response.statusCode == 200) {
        for (var item in response.data) {
          getProductsData.add(ProductsShop.fromJson(item));
        }
        // getProductsData = (response.data)
        //     .map((product) => ProductsShop.fromJson(product))
        //     .toList();
        emit(ShopingSuccses());
      } else {
        emit(ShopingFailure(error: response.statusMessage.toString()));
        log(response.statusMessage.toString());
      }
    } catch (e) {
      emit(ShopingFailure(error: e.toString()));
      log(e.toString());
    }
  }
}
