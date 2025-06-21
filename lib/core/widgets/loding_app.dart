import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class LodingApp extends StatelessWidget {
  const LodingApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2, // عدد العناصر (صف واحد يحتوي على عنصرين)
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h), // مسافة بين المنتجات
          child: SkeletonLoader(
            builder: Row(
              children: [
                // العنصر الأول
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! container image
                      Stack(
                        children: [
                          Container(
                            height: 165.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(5, 8),
                                  blurStyle: BlurStyle.normal,
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(14.r),
                              color: Colors.grey[300], // لون الهيكل العظمي
                            ),
                          ),
                          Positioned(
                            bottom: 5.h,
                            right: 5.w,
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // لون الهيكل العظمي
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5.h,
                            left: 5.w,
                            child: Container(
                              width: 60.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // لون الهيكل العظمي
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      //! product name
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Container(
                          width: 120.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // لون الهيكل العظمي
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //! text for price
                          SizedBox(
                            width: 55.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300], // لون الهيكل العظمي
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Container(
                                  width: 40.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300], // لون الهيكل العظمي
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //! add to cart button
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // لون الهيكل العظمي
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.w), // مسافة بين العنصرين
                // العنصر الثاني
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! container image
                      Stack(
                        children: [
                          Container(
                            height: 165.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(5, 8),
                                  blurStyle: BlurStyle.normal,
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(14.r),
                              color: Colors.grey[300], // لون الهيكل العظمي
                            ),
                          ),
                          Positioned(
                            bottom: 5.h,
                            right: 5.w,
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // لون الهيكل العظمي
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5.h,
                            left: 5.w,
                            child: Container(
                              width: 60.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // لون الهيكل العظمي
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      //! product name
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Container(
                          width: 120.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // لون الهيكل العظمي
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //! text for price
                          SizedBox(
                            width: 55.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300], // لون الهيكل العظمي
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Container(
                                  width: 40.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300], // لون الهيكل العظمي
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //! add to cart button
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // لون الهيكل العظمي
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
          ),
        );
      },
    );
  }
}

//! home
class LodingAppList extends StatelessWidget {
  const LodingAppList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      builder: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! container image
          Stack(
            children: [
              Container(
                height: 165.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(5, 8),
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 1,
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(14.r),
                  color: Colors.grey[300], // لون الهيكل العظمي
                ),
              ),
              Positioned(
                bottom: 5.h,
                right: 5.w,
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // لون الهيكل العظمي
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 5.h,
                left: 5.w,
                child: Container(
                  width: 60.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // لون الهيكل العظمي
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          //! product name
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Container(
              width: 120.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.grey[300], // لون الهيكل العظمي
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //! text for price
              SizedBox(
                width: 55.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // لون الهيكل العظمي
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: 40.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // لون الهيكل العظمي
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              //! add to cart button
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // لون الهيكل العظمي
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ],
      ),
      items: 1, // عدد العناصر
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }
}
