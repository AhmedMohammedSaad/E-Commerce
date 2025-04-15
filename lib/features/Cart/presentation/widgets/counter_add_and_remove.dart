
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CunterAddandRemove extends StatelessWidget {
  const CunterAddandRemove({
    super.key,
    required this.price,
  });

  final CartModel price;

  //! counter
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        // تحويل السعر إلى int

        return Row(children: [
          //! عرض المبلغ الإجمالي
          SizedBox(
            width: 70.w,
            child: Text(
              overflow: TextOverflow.ellipsis,
              "${price.products!.price} LE",
              style: StyleTextApp.font16ColorblacFontWeightBold,
            ),
          ),
          //! هذا الصف يحتوي على أزرار العداد (زيادة ونقصان)
        ]);
      },
    );
  }
}
