import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:advanced_app/features/DetailsScreen/data/models/comments/comments.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/cubit/detailsscreen_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductComments extends StatelessWidget {
  const ProductComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsscreenCubit, DetailsscreenState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        List<Comments> comments = context.read<DetailsscreenCubit>().commentsList;
        if (state is CommentLoading) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              size: 80,
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is CommentSuccses) {
          if (comments.isEmpty) {
            return Center(child: Text("no_comments".tr()));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) {
              final comment = comments[index];
              // طباعة التعليق

              if (comment.comments != null && comment.comments!.isNotEmpty) {
                // استخدام الفهرس 0 للوصول إلى أول تعليق (أو أي index آخر إذا كنت تريد عنصرًا محددًا)
                final innerComment = comment.comments![index];
                final user = innerComment.users?.name ?? ""; // قيمة افتراضية
                final comm = innerComment.comment ?? ""; // قيمة افتراضية

                return ListTile(
                  title: Text(
                    user.toString(),
                    style: StyleTextApp.font14ColorblacFontWeightBold,
                  ),
                  subtitle: Text(
                    comm.toString(),
                    style: StyleTextApp.font14Colorblac,
                  ),
                );
              } else {
                return ListTile(
                  title: Text(
                    "",
                    style: StyleTextApp.font14ColorblacFontWeightBold,
                  ),
                  subtitle: Text(
                    "",
                    style: StyleTextApp.font14Colorblac,
                  ),
                );
              }
            },
          );
        }

        return Center(child: Text("no_internet".tr()));
      },
    );
  }
}
