import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/home/data/models/model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 140.h,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      itemCount: CarouselSliderClass.carouselSliderList.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 7.0.h, vertical: 7.h),
            width: 370.w,
            margin: EdgeInsets.symmetric(horizontal: 5.0.h, vertical: 15.h),
            decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26, // لون أسود مع شفافية
                  offset: Offset(4, 4), // اتجاه ومسافة الظل
                  blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                  spreadRadius: 2, // عرض الظل
                  blurRadius: 8, // نعومة الظل
                ),
              ],
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 128.w,
                  height: 121.h,
                  child: Column(
                    spacing: 2.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CarouselSliderClass.carouselSliderList[index].title,
                        style: StyleTextApp.font14ColorblacFontWeightBold,
                      ),
                      Text(CarouselSliderClass
                          .carouselSliderList[index].supTitle),
                    ],
                  ),
                ),
                Container(
                  height: 121.h,
                  width: 91.w,
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
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                          CarouselSliderClass.carouselSliderList[index].image,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
