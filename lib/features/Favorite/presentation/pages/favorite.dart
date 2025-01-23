import 'dart:developer';

import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Favorite/data/models/favorite/favorite.dart';
import 'package:advanced_app/features/Favorite/presentation/cubit/favorite_cubit.dart';
import 'package:advanced_app/features/Favorite/presentation/widgets/faveorite_prodect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! AppBar
      appBar: appBar(leding: false, title: 'Favorite'),
      body: BlocProvider(
        create: (context) =>
            FavoriteCubit(apiConsumer: DioConsumer())..getFavorite(),
        child: BlocConsumer<FavoriteCubit, FavoriteState>(
            listener: (BuildContext context, state) {},
            builder: (context, state) {
              List<FavoriteModel> favorites =
                  context.read<FavoriteCubit>().favorites;
              log(favorites.toString());
              if (state is FavoriteLoding) {
                return const LodingApp();
              } else if (state is FavoriteSuccses) {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: favorites.length,
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
                            blurStyle:
                                BlurStyle.normal, // تأثير طبيعي على الحواف
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
                          FavortColumnImageNameShopIcon(
                        favorite: favorites[index],
                        index: index,
                      ),
                    );
                  },
                );
              } else if (state is FavoriteError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
