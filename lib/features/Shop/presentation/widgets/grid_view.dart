import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/column_image_name_shopicon.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridviewForWidget extends StatelessWidget {
  const GridviewForWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: SaleModel.salleSliderList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 19.h,
        crossAxisSpacing: 4.w,
        mainAxisExtent: 270.h,
      ),
      itemBuilder: (BuildContext context, int index) {
        //! this container is for widget image and shop ....
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          height: 240.h,
          width: 200.w,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // لون أسود مع شفافية
                offset: Offset(1, 1), // اتجاه ومسافة الظل
                blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                spreadRadius: 1, // عرض الظل
                blurRadius: 7, // نعومة الظل
              ),
            ],
            border: Border.all(color: ColorManager.green),
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child:
              //! column for image and text price and shop icon
              ColumnImageNameShopIcon(index: index),
        );
      },
    )
        .animate()
        // .fadeIn(duration: 600.ms)
        .then(delay: 200.ms)
        .slide(
          begin: const Offset(1.1, 1.1), // Start from the right
          end: Offset.zero, // End at the original position
          duration: 300.ms,
        );
  }
}
