import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/product_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  final supabase = Supabase.instance.client;

  // ===== Advertisement Methods =====
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

  // ===== Product Methods =====
  Future<void> getProducts() async {
    emit(GetProductsLoading());
    try {
      final response = await supabase
          .from('products')
          .select()
          .order('created_at', ascending: false);

      // Convert the raw data to Product objects
<<<<<<< HEAD

      emit(GetProductsSuccess(response));
=======
      final products = response.map((json) => Product.fromJson(json)).toList();

      emit(GetProductsSuccess(products));
>>>>>>> 2b4773d99e26b943838e3426dc68e3f7a3f06bea
    } catch (e) {
      emit(GetProductsFailure(e.toString()));
    }
  }

  Future<void> addProduct({
    required String name,
    required double price,
    required String description,
    required String imageUrl,
    String? category,
  }) async {
    emit(AddProductLoading());
    try {
      // Create product data with all required fields
      final productData = {
        'product_name': name,
        'price': price,
        'discription':
            description, // Note: the field name has a typo in the DB schema
        'image_url': imageUrl,
        'created_at': DateTime.now().toIso8601String(),
      };

      // Add category if provided
      if (category != null && category.isNotEmpty) {
        productData['category'] = category;
      }

      // Insert the product and get the result
      final result =
          await supabase.from('products').insert(productData).select().single();

      // Refresh products list
      await getProducts();
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required double price,
    required String description,
    required String imageUrl,
    String? category,
  }) async {
    emit(UpdateProductLoading());
    try {
      final updateData = {
        'product_name': name,
        'price': price,
        'discription': description,
        'image_url': imageUrl,
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Add category if provided
      if (category != null && category.isNotEmpty) {
        updateData['category'] = category;
      }

      await supabase
          .from('products')
          .update(updateData)
          .eq('product_id', id)
          .select()
          .single();

      await getProducts(); // Refresh the list
      emit(UpdateProductSuccess());
    } catch (e) {
      emit(UpdateProductFailure(e.toString()));
    }
  }

  Future<void> deleteProduct(String id) async {
    emit(DeleteProductLoading());
    try {
      await supabase.from('products').delete().eq('product_id', id);
      await getProducts(); // Refresh the list
      emit(DeleteProductSuccess());
    } catch (e) {
      emit(DeleteProductFailure(e.toString()));
    }
  }

  // ===== Analytics Methods =====
  Future<void> getAnalytics() async {
    emit(GetAnalyticsLoading());
    try {
      // Get total products
      final productsResponse = await supabase.from('products').select('count');
      final totalProducts = productsResponse[0]['count'];

      // Get total advertisements
      final adsResponse = await supabase.from('advertisements').select('count');
      final totalAds = adsResponse[0]['count'];

      // In a real app, you'd have tables for sales/orders to calculate these values
      // For demo purposes, we'll use placeholder values
      const totalSales = 42;
      const totalRevenue = 8750.50;

      emit(GetAnalyticsSuccess(
        totalProducts: totalProducts,
        totalAdvertisements: totalAds,
        totalSales: totalSales,
        totalRevenue: totalRevenue,
      ));
    } catch (e) {
      emit(GetAnalyticsFailure(e.toString()));
    }
  }
}
