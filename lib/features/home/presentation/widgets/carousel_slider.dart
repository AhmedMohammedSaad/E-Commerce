import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:advanced_app/features/home/data/models/advertisements/advertisements.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAdvertisements(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AdvertisementsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: ColorManager.red,
              ),
            );
          }
        },
        builder: (context, state) {
          List<Advertisements> advertisements =
              context.read<HomeCubit>().advertisementsList;
          if (state is AdvertisementsLoading) {
            return LoadingAnimationWidget.dotsTriangle(
              size: 80,
              color: ColorManager.green,
            );
          } else if (state is AdvertisementsSuccses) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: 135.h,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
              itemCount: advertisements.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.0.h, vertical: 7.h),
                  width: 370.w,
                  margin:
                      EdgeInsets.symmetric(horizontal: 5.0.h, vertical: 15.h),
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
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 2.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //! title name
                              SizedBox(
                                width: 128.w,
                                child: Text(
                                  advertisements[index].titleName.toString(),
                                  style: StyleTextApp
                                      .font14ColorblacFontWeightBold,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              //! descreption
                              SizedBox(
                                width: 128.w,
                                height: 50.h,
                                child: Text(
                                  advertisements[index].descreption.toString(),
                                  style: StyleTextApp.font12Colorgray,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
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
                              blurStyle:
                                  BlurStyle.normal, // تأثير طبيعي على الحواف
                              spreadRadius: 2, // عرض الظل
                              blurRadius: 8, // نعومة الظل
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.r),
                          child: CachedNetworkImage(
                            imageUrl:
                                //! image url
                                advertisements[index].imageUrl.toString(),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => SizedBox(
                              height: 121.h,
                              width: 91.w,
                              child: Card(
                                child: LoadingAnimationWidget.dotsTriangle(
                                  size: 90,
                                  color: ColorManager.green,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons
                      .signal_wifi_statusbar_connected_no_internet_4_sharp),
                  Text(
                    'No Internet Connection',
                    style: StyleTextApp.font16ColorblacFontWeightBold,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
