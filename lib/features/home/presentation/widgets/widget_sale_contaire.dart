import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlaleWidgetContainer extends StatelessWidget {
  const SlaleWidgetContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225.h,
      child: ListView.builder(
        primary: true,
        scrollDirection: Axis.horizontal,
        itemCount: SaleModel.salleSliderList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                height: 185.h,
                width: 200.w,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26, // لون أسود مع شفافية
                      offset: Offset(5, 8), // اتجاه ومسافة الظل
                      blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                      spreadRadius: 2, // عرض الظل
                      blurRadius: 7, // نعومة الظل
                    ),
                  ],
                  borderRadius: BorderRadius.circular(14.r),
                  image: DecorationImage(
                    image: NetworkImage(
                      SaleModel.salleSliderList[index].image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //! container Sales
              Positioned(
                top: 0.h, // المسافة من الأعلى
                right: 20.w, // المسافة من اليمين
                child: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 44.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // لون أسود مع شفافية
                        offset: Offset(4, 4), // اتجاه ومسافة الظل
                        blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                        spreadRadius: 2, // عرض الظل
                        blurRadius: 8, // نعومة الظل
                      ),
                    ],
                    color: ColorManager.green, // لون الشريط
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7.r),
                      bottomRight: Radius.circular(7.r),
                    ),
                  ),
                  child: Text(SaleModel.salleSliderList[index].sale,
                      style: StyleTextApp.font14ColorWhiteFontWeightBold),
                ),
              ),
              //! the container is Opacity
              Positioned(
                bottom: 40.h,
                left: 8.w,
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: ColorManager.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(14.r),
                      bottomRight: Radius.circular(14.r),
                    ),
                  ),
                  child: Text(SaleModel.salleSliderList[index].title,
                      style: StyleTextApp.font14ColorWhiteFontWeightBold),
                ),
              ),
            ],
          )
              .animate()
              // .fadeIn(duration: 600.ms)
              .then(delay: 200.ms)
              .slide(
                begin: const Offset(0.1, 1.0), // Start from the right
                end: Offset.zero, // End at the original position
                duration: 200.ms,
              );
        },
      ),
    );
  }
}
