import 'package:advanced_app/core/api/dio_consumer.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/Favorite/data/models/favorite_model/favorite_model.dart';
import 'package:advanced_app/features/Favorite/presentation/cubit/favorite_cubit.dart';
import 'package:advanced_app/features/Favorite/presentation/widgets/faveorite_prodect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favorite extends StatelessWidget {
  Favorite({super.key});
  final FavoriteModel favoriteModel = FavoriteModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! AppBar
      appBar: appBar(leding: false, title: 'Favorite'),
      body: BlocProvider(
        create: (context) =>
            FavoriteCubit(apiConsumer: DioConsumer())..getFavorite(),
        child: BlocConsumer<FavoriteCubit, FavoriteState>(
            listener: (BuildContext context, state) {
          if (state is FavoriteError) {
            Center(
              child: Text(state.error),
            );
          }
        }, builder: (context, state) {
          List<FavoriteModel> favorites =
              context.read<FavoriteCubit>().favorites;

          return state is FavoriteLoding
              ? const LodingApp()
              : favorites.isNotEmpty
                  ? GridView.builder(
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
                            border: Border.all(color: AppColors.primaryColor),
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child:
                              //! column for image and text price and shop icon
                              FavortColumnImageNameShopIcon(
                            favorite: favorites[index],
                            index: index,
                            listFavorite: favorites,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No Favorite",
                        style: StyleTextApp.font14ColorblacFontWeightBold,
                      ),
                    );
        }),
      ),
    );
  }
}
