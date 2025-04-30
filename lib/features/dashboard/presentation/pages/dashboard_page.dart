import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../domain/models/product_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();

  late TabController _tabController;
  late DashboardCubit _dashboardCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _dashboardCubit = DashboardCubit();
    _dashboardCubit.getAdvertisements();
    _dashboardCubit.getProducts();
    _dashboardCubit.getAnalytics();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _productNameController.dispose();
    _productPriceController.dispose();
    _tabController.dispose();
    _dashboardCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dashboardCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('dashboard_title'.tr()),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: const Icon(Icons.shopping_bag),
                text: 'products_tab'.tr(),
              ),
              Tab(
                icon: const Icon(Icons.campaign),
                text: 'advertisements_tab'.tr(),
              ),
              Tab(
                icon: const Icon(Icons.analytics),
                text: 'analytics_tab'.tr(),
              ),
            ],
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
          ),
        ),
        floatingActionButton: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return _tabController.index == 0
                ? FloatingActionButton(
                    onPressed: () => _showAddProductDialog(context),
                    child: const Icon(Icons.add),
                    backgroundColor: AppColors.primaryColor,
                  )
                : _tabController.index == 1
                    ? FloatingActionButton(
                        onPressed: () => _showAddDialog(context),
                        child: const Icon(Icons.add),
                        backgroundColor: AppColors.primaryColor,
                      )
                    : const SizedBox.shrink();
          },
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildProductsTab(),
            _buildAdvertisementsTab(),
            _buildAnalyticsTab(),
          ],
        ),
      ),
    );
  }

  // Products Tab
  Widget _buildProductsTab() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is GetProductsLoading) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              size: 50,
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is GetProductsSuccess) {
          if (state.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80.sp,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'no_products'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.sp),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      product.imageUrl,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60.w,
                          height: 60.h,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    product.productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        '${product.price} LE',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            _showEditProductDialog(context, product),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmation(
                          context,
                          product.productId,
                          isProduct: true,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is GetProductsFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 80.sp,
                  color: Colors.red[300],
                ),
                SizedBox(height: 16.h),
                Text(
                  'failed_to_load_products'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        // Default state (DashboardInitial or other states)
        return Center(
          child: LoadingAnimationWidget.dotsTriangle(
            size: 50,
            color: AppColors.primaryColor,
          ),
        );
      },
    );
  }

  // Advertisements Tab
  Widget _buildAdvertisementsTab() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is GetAdvertisementsLoading) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              size: 50,
              color: AppColors.primaryColor,
            ),
          );
        }

        if (state is GetAdvertisementsSuccess) {
          final advertisements = state.advertisements;

          if (advertisements.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.campaign_outlined,
                    size: 80.sp,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'no_advertisements'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: advertisements.length,
            itemBuilder: (context, index) {
              final ad = advertisements[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.sp),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      ad['image_url'] ?? '',
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60.w,
                          height: 60.h,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    ad['title_name'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Text(
                    ad['descreption'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditDialog(context, ad),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmation(
                          context,
                          ad['id'],
                          isProduct: false,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: Text('no_advertisements'.tr()),
        );
      },
    );
  }

  // Analytics Tab
  Widget _buildAnalyticsTab() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is GetAnalyticsLoading) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              size: 50,
              color: AppColors.primaryColor,
            ),
          );
        }

        if (state is GetAnalyticsSuccess) {
          return Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'product_stats'.tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 24.h),
                _buildStatCard(
                  icon: Icons.shopping_bag,
                  title: 'total_products'.tr(),
                  value: state.totalProducts.toString(),
                  color: Colors.blue,
                ),
                SizedBox(height: 16.h),
                _buildStatCard(
                  icon: Icons.campaign,
                  title: 'total_advertisements'.tr(),
                  value: state.totalAdvertisements.toString(),
                  color: Colors.orange,
                ),
                SizedBox(height: 16.h),
                _buildStatCard(
                  icon: Icons.sell,
                  title: 'total_sales'.tr(),
                  value: state.totalSales.toString(),
                  color: Colors.green,
                ),
                SizedBox(height: 16.h),
                _buildStatCard(
                  icon: Icons.attach_money,
                  title: 'total_revenue'.tr(),
                  value: '${state.totalRevenue} LE',
                  color: Colors.purple,
                ),
              ],
            ),
          );
        }

        return Center(
          child: Text('Failed to load analytics'),
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 30.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Add Product Dialog
  void _showAddProductDialog(BuildContext context) {
    _productNameController.clear();
    _productPriceController.clear();
    _descriptionController.clear();
    _imageUrlController.clear();
    final _categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('add_product'.tr()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'product_name'.tr()),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _productPriceController,
                decoration: InputDecoration(labelText: 'product_price'.tr()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _descriptionController,
                decoration:
                    InputDecoration(labelText: 'product_description'.tr()),
                maxLines: 3,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'product_category'.tr()),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'product_image'.tr()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              final price =
                  double.tryParse(_productPriceController.text) ?? 0.0;
              _dashboardCubit.addProduct(
                name: _productNameController.text,
                price: price,
                description: _descriptionController.text,
                imageUrl: _imageUrlController.text,
                category: _categoryController.text,
              );
              Navigator.pop(dialogContext);
            },
            child: Text('add'.tr()),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Edit Product Dialog
  void _showEditProductDialog(BuildContext context, Product product) {
    _productNameController.text = product.productName;
    _productPriceController.text = product.price.toString();
    _descriptionController.text = product.description;
    _imageUrlController.text = product.imageUrl;
    final _categoryController = TextEditingController();
    _categoryController.text = product.category ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('edit_product'.tr()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'product_name'.tr()),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _productPriceController,
                decoration: InputDecoration(labelText: 'product_price'.tr()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _descriptionController,
                decoration:
                    InputDecoration(labelText: 'product_description'.tr()),
                maxLines: 3,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'product_category'.tr()),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'product_image'.tr()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              final price =
                  double.tryParse(_productPriceController.text) ?? 0.0;
              _dashboardCubit.updateProduct(
                id: product.productId,
                name: _productNameController.text,
                price: price,
                description: _descriptionController.text,
                imageUrl: _imageUrlController.text,
                category: _categoryController.text,
              );
              Navigator.pop(dialogContext);
            },
            child: Text('update'.tr()),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Add Advertisement Dialog
  void _showAddDialog(BuildContext context) {
    _titleController.clear();
    _descriptionController.clear();
    _imageUrlController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('add_advertisement'.tr()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'title'.tr()),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _descriptionController,
                decoration:
                    InputDecoration(labelText: 'description_field'.tr()),
                maxLines: 3,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'image_url'.tr()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              _dashboardCubit.addAdvertisement(
                titleName: _titleController.text,
                description: _descriptionController.text,
                imageUrl: _imageUrlController.text,
              );
              Navigator.pop(dialogContext);
            },
            child: Text('add'.tr()),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Edit Advertisement Dialog
  void _showEditDialog(BuildContext context, Map<String, dynamic> ad) {
    _titleController.text = ad['title_name'] ?? '';
    _descriptionController.text = ad['descreption'] ?? '';
    _imageUrlController.text = ad['image_url'] ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('edit_advertisement'.tr()),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'title'.tr()),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _descriptionController,
                decoration:
                    InputDecoration(labelText: 'description_field'.tr()),
                maxLines: 3,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'image_url'.tr()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              _dashboardCubit.updateAdvertisement(
                id: ad['id'].toString(),
                titleName: _titleController.text,
                description: _descriptionController.text,
                imageUrl: _imageUrlController.text,
              );
              Navigator.pop(dialogContext);
            },
            child: Text('update'.tr()),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // Delete Confirmation Dialog
  void _showDeleteConfirmation(BuildContext context, dynamic id,
      {required bool isProduct}) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
            isProduct ? 'delete_product'.tr() : 'delete_advertisement'.tr()),
        content: Text('delete_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              if (isProduct) {
                _dashboardCubit.deleteProduct(id.toString());
              } else {
                _dashboardCubit.deleteAdvertisement(id.toString());
              }
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }
}
