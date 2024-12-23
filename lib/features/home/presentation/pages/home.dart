import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/features/home/data/models/category.dart';
import 'package:advanced_app/features/home/presentation/widgets/carousel_slider.dart';
import 'package:advanced_app/features/home/presentation/widgets/sale_text.dart';
import 'package:advanced_app/features/home/presentation/widgets/widget_sale_contaire.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Welcome Back!', leding: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //! Carousel Slider Contaires
            const CarouselSliderWidget(),

            //! sale widget text
            SaleText('Categorys'),
            //! Categorys widgets
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: 90.h,
                child: ListView.builder(
                  primary: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryModel.categrys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 10.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      height: 61.h,
                      width: 79.w,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        border: Border.all(color: ColorManager.green),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(
                                47, 0, 0, 0), // لون أسود مع شفافية
                            offset: Offset(2, 3), // اتجاه ومسافة الظل
                            blurStyle:
                                BlurStyle.normal, // تأثير طبيعي على الحواف
                            spreadRadius: 2, // عرض الظل
                            blurRadius: 7, // نعومة الظل
                          ),
                        ],
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        spacing: 2.h,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                              CategoryModel.categrys[index].urlImage,
                            ),
                          ),
                          Text(
                            CategoryModel.categrys[index].nameCategory,
                            style: StyleTextApp.font12ColorblacFontWeightBold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            //! sale widget text
            SaleText('Sale'),
            //! Widgets image Sale Container

            const SlaleWidgetContainer(),
          ],
        ),
      ),
    );
  }
}
