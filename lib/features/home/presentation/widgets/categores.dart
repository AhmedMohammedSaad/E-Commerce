import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Categories/presentation/pages/categories.dart';
import 'package:advanced_app/features/home/data/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCategorys extends StatelessWidget {
  const ListCategorys({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        primary: true,
        scrollDirection: Axis.horizontal,
        itemCount: CategoryModel.categrys.length,
        itemBuilder: (BuildContext context, int index) {
          //! container
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => CategorieScreen(
                    categorieName: CategoryModel.categrys[index].nameCategory,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 10.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
              ),
              height: 61.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: ColorManager.white,
                border: Border.all(color: ColorManager.green),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(47, 0, 0, 0), // لون أسود مع شفافية
                    offset: Offset(2, 3), // اتجاه ومسافة الظل
                    blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                    spreadRadius: 2, // عرض الظل
                    blurRadius: 7, // نعومة الظل
                  ),
                ],
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                spacing: 5.h,
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
            ),
          );
        },
      ),
    );
  }
}
