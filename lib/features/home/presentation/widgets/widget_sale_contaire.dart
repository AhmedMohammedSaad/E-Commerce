import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/pages/details_screen.dart';
import 'package:advanced_app/features/home/data/models/sale_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SlaleWidgetContainer extends StatelessWidget {
  const SlaleWidgetContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      primary: true,
      itemCount: SaleModel.salleSliderList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ProductDetailsScreen(
                  index: index,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // تكبير الصفحة عند الانتقال
                  const begin = Offset(0.1, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
              ),
            );
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 185.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // لون أسود مع شفافية
                        offset: Offset(3, 5), // اتجاه ومسافة الظل
                        blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
                        spreadRadius: 2, // عرض الظل
                        blurRadius: 11, // نعومة الظل
                      ),
                    ],
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: CachedNetworkImage(
                      imageUrl: SaleModel.salleSliderList[index].image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: 185.h,
                        width: 200.w,
                        child: Card(
                          child: LoadingAnimationWidget.dotsTriangle(
                            size: 80,
                            color: ColorManager.green,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              //! container Sales
              Positioned(
                top: 8.h, // المسافة من الأعلى
                right: 28.w, // المسافة من اليمين
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
                bottom: 8.h,
                left: 16.w,
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: MediaQuery.of(context).size.width * 0.91,
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
              ),
        );
      },
    );
  }
}
