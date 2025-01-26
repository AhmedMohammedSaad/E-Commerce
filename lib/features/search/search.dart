// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
// import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
// import 'package:advanced_app/features/Shop/presentation/widgets/column_image_name_shopicon.dart';

// class Search extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = ''; // مسح نص البحث
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => Navigator.of(context).pop(), // الخروج من شاشة البحث
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return _buildSearchResults(context);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return _buildSearchResults(context);
//   }

//   Widget _buildSearchResults(BuildContext context) {
//     final shopCubit = context.read<ShopCubit>();
//     final List<ProductsShop> allProducts = shopCubit.getProductsData;

//     final List<ProductsShop> searchResults = query.isEmpty
//         ? []
//         : allProducts
//             .where((item) =>
//                 item.productName!.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//     if (searchResults.isEmpty) {
//       return const Center(
//         child: Text('لا توجد نتائج بحث'),
//       );
//     }

//     return ListView.builder(
//       itemCount: searchResults.length,
//       itemBuilder: (context, index) {
//         return ColumnImageNameShopIcon(
//           index: index,
//           getProductData: searchResults,
//         );
//       },
//     );
//   }
// }
