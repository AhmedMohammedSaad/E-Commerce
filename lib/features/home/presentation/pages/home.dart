import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Shop/presentation/cubit/shop_cubit.dart';
import 'package:advanced_app/features/Shop/presentation/pages/shop.dart';
import 'package:advanced_app/features/Shop/presentation/pages/search.dart';
import 'package:advanced_app/features/home/presentation/widgets/carousel_slider.dart';
import 'package:advanced_app/features/home/presentation/widgets/categores.dart';
import 'package:advanced_app/features/home/presentation/widgets/widget_sale_contaire.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Function to handle search
  void _handleSearch(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Search(quary: query),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ShopCubit(apiConsumer: DioConsumer())..getProducts(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'hello'.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'welcome_to_shop'.tr(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.primaryColor,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey[400],
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'search_products'.tr(),
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 15.h),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear, color: Colors.grey[400]),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                    )
                                  : null,
                            ),
                            onSubmitted: (_) => _handleSearch(context),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          height: 30.h,
                          width: 1,
                          color: Colors.grey[200],
                        ),
                        SizedBox(width: 10.w),
                        // Search button
                        GestureDetector(
                          onTap: () => _handleSearch(context),
                          child: const Icon(
                            Icons.search,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Filter button
                        // GestureDetector(
                        //   onTap: () {
                        //     // Show filter options (categories, price range, etc.)
                        //     showModalBottomSheet(
                        //       context: context,
                        //       isScrollControlled: true,
                        //       backgroundColor: Colors.transparent,
                        //       builder: (context) =>
                        //           _buildFilterBottomSheet(context),
                        //     );
                        //   },
                        //   child: const Icon(
                        //     Icons.tune,
                        //     color: AppColors.primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),

              // Carousel Slider
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  child: const CarouselSliderWidget(),
                ),
              ),

              // Categories Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'categories'.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to categories screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Scaffold(
                                body: Shop(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'see_all'.tr(),
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories List
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: const ListCategorys(),
                ),
              ),

              // Sales Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'special_offers'.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to sales screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Scaffold(
                                body: Shop(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'see_all'.tr(),
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sale Items
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: const SlaleWidgetContainer(),
                ),
              ),

              // Recent Products Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'new_arrivals'.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to new products screen
                        },
                        child: Text(
                          'see_all'.tr(),
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // More products grid - placeholder
              SliverToBoxAdapter(
                child: Container(
                  height: 200.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'coming_soon'.tr(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom spacing
              SliverToBoxAdapter(
                child: SizedBox(height: 20.h),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // //! Function to build the filter bottom sheet
  // Widget _buildFilterBottomSheet(BuildContext context) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.8,
  //     padding: EdgeInsets.all(20.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(25.r),
  //         topRight: Radius.circular(25.r),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Header with close button
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'filter_products'.tr(),
  //               style: TextStyle(
  //                 fontSize: 18.sp,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             IconButton(
  //               icon: const Icon(Icons.close),
  //               onPressed: () => Navigator.pop(context),
  //             ),
  //           ],
  //         ),
  //         const Divider(),
  //         SizedBox(height: 10.h),

  //         // Categories filter
  //         Text(
  //           'categories'.tr(),
  //           style: TextStyle(
  //             fontSize: 16.sp,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 10.h),
  //         Wrap(
  //           spacing: 10.w,
  //           children: [
  //             _buildFilterChip('all'.tr()),
  //             _buildFilterChip('electronics'.tr()),
  //             _buildFilterChip('clothing'.tr()),
  //             _buildFilterChip('home_kitchen'.tr()),
  //             _buildFilterChip('sports'.tr()),
  //             _buildFilterChip('toys'.tr()),
  //           ],
  //         ),
  //         SizedBox(height: 20.h),

  //         // Price Range filter
  //         Text(
  //           'price_range'.tr(),
  //           style: TextStyle(
  //             fontSize: 16.sp,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 10.h),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 padding:
  //                     EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey.shade300),
  //                   borderRadius: BorderRadius.circular(8.r),
  //                 ),
  //                 child: TextField(
  //                   decoration: InputDecoration(
  //                     hintText: 'min'.tr(),
  //                     border: InputBorder.none,
  //                     contentPadding: EdgeInsets.zero,
  //                   ),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 15.w),
  //             Expanded(
  //               child: Container(
  //                 padding:
  //                     EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey.shade300),
  //                   borderRadius: BorderRadius.circular(8.r),
  //                 ),
  //                 child: TextField(
  //                   decoration: InputDecoration(
  //                     hintText: 'max'.tr(),
  //                     border: InputBorder.none,
  //                     contentPadding: EdgeInsets.zero,
  //                   ),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 20.h),

  //         // Sort By filter
  //         Text(
  //           'sort_by'.tr(),
  //           style: TextStyle(
  //             fontSize: 16.sp,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 10.h),
  //         Wrap(
  //           spacing: 10.w,
  //           children: [
  //             _buildFilterChip('newest'.tr()),
  //             _buildFilterChip('price_low_high'.tr()),
  //             _buildFilterChip('price_high_low'.tr()),
  //             _buildFilterChip('popularity'.tr()),
  //           ],
  //         ),

  //         const Spacer(),

  //         // Apply button
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               // Apply filters and navigate to filtered results
  //               Navigator.pop(context);
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: AppColors.primaryColor,
  //               padding: EdgeInsets.symmetric(vertical: 15.h),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12.r),
  //               ),
  //             ),
  //             child: Text(
  //               'apply_filters'.tr(),
  //               style: TextStyle(
  //                 fontSize: 16.sp,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Helper method to build filter chips
  // Widget _buildFilterChip(String label) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 8.h),
  //     child: FilterChip(
  //       label: Text(label),
  //       onSelected: (selected) {},
  //       backgroundColor: Colors.grey.shade100,
  //       selectedColor: AppColors.primaryColor.withOpacity(0.2),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.r),
  //       ),
  //     ),
  //   );
  // }
}
