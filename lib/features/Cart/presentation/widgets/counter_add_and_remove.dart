// import 'package:advanced_app/core/color/colors.dart';
// import 'package:advanced_app/core/textStyle/text_style.dart';
// import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
// import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CunterAddandRemove extends StatelessWidget {
//   const CunterAddandRemove({
//     super.key,
//     required this.price,
//   });

//   final CartModel price;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartCubit, CartState>(
//       builder: (context, state) {
//         // Get the current quantity from the cubit
//         final productId = price.forProductId ?? '';
//         final quantity = context.read<CartCubit>().getQuantity(productId);

//         return Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.r),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   _buildCounterButton(
//                     icon: Icons.remove,
//                     onTap: () {
//                       // Decrement quantity
//                       context.read<CartCubit>().decrementQuantity(productId);
//                     },
//                   ),
//                   Container(
//                     width: 36.w,
//                     height: 30.h,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       border: Border.symmetric(
//                         vertical: BorderSide(color: Colors.grey.shade300),
//                       ),
//                     ),
//                     child: Text(
//                       quantity.toString(),
//                       style: StyleTextApp.font14ColorblacFontWeightBold,
//                     ),
//                   ),
//                   _buildCounterButton(
//                     icon: Icons.add,
//                     onTap: () {
//                       // Increment quantity
//                       context.read<CartCubit>().incrementQuantity(productId);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 12.w),
//             // Show the item price with quantity
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Text(
//                 "${int.parse(price.products?.price ?? '0') * quantity} LE",
//                 style: StyleTextApp.font14ColorblacFontWeightBold.copyWith(
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildCounterButton(
//       {required IconData icon, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: 30.w,
//         height: 30.h,
//         alignment: Alignment.center,
//         child: Icon(
//           icon,
//           size: 16.sp,
//           color: AppColors.primaryColor,
//         ),
//       ),
//     );
//   }
// }
