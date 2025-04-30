part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

// ===== Advertisement States =====
// Get Advertisements States
class GetAdvertisementsLoading extends DashboardState {}

class GetAdvertisementsSuccess extends DashboardState {
  final List<Map<String, dynamic>> advertisements;
  const GetAdvertisementsSuccess(this.advertisements);

  @override
  List<Object> get props => [advertisements];
}

class GetAdvertisementsFailure extends DashboardState {
  final String error;
  const GetAdvertisementsFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Add Advertisement States
class AddAdvertisementLoading extends DashboardState {}

class AddAdvertisementSuccess extends DashboardState {}

class AddAdvertisementFailure extends DashboardState {
  final String error;
  const AddAdvertisementFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Update Advertisement States
class UpdateAdvertisementLoading extends DashboardState {}

class UpdateAdvertisementSuccess extends DashboardState {}

class UpdateAdvertisementFailure extends DashboardState {
  final String error;
  const UpdateAdvertisementFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Delete Advertisement States
class DeleteAdvertisementLoading extends DashboardState {}

class DeleteAdvertisementSuccess extends DashboardState {}

class DeleteAdvertisementFailure extends DashboardState {
  final String error;
  const DeleteAdvertisementFailure(this.error);

  @override
  List<Object> get props => [error];
}

// ===== Product States =====
// Get Products States
class GetProductsLoading extends DashboardState {}

class GetProductsSuccess extends DashboardState {
  final List<Product> products;
  const GetProductsSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class GetProductsFailure extends DashboardState {
  final String error;
  const GetProductsFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Add Product States
class AddProductLoading extends DashboardState {}

class AddProductSuccess extends DashboardState {}

class AddProductFailure extends DashboardState {
  final String error;
  const AddProductFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Update Product States
class UpdateProductLoading extends DashboardState {}

class UpdateProductSuccess extends DashboardState {}

class UpdateProductFailure extends DashboardState {
  final String error;
  const UpdateProductFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Delete Product States
class DeleteProductLoading extends DashboardState {}

class DeleteProductSuccess extends DashboardState {}

class DeleteProductFailure extends DashboardState {
  final String error;
  const DeleteProductFailure(this.error);

  @override
  List<Object> get props => [error];
}

// ===== Analytics States =====
class GetAnalyticsLoading extends DashboardState {}

class GetAnalyticsSuccess extends DashboardState {
  final int totalProducts;
  final int totalAdvertisements;
  final int totalSales;
  final double totalRevenue;

  const GetAnalyticsSuccess({
    required this.totalProducts,
    required this.totalAdvertisements,
    required this.totalSales,
    required this.totalRevenue,
  });

  @override
  List<Object> get props =>
      [totalProducts, totalAdvertisements, totalSales, totalRevenue];
}

class GetAnalyticsFailure extends DashboardState {
  final String error;
  const GetAnalyticsFailure(this.error);

  @override
  List<Object> get props => [error];
}
