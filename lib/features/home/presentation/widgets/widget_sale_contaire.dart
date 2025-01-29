import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/core/widgets/loding_app.dart';
import 'package:advanced_app/features/DetailsScreen/presentation/pages/details_screen.dart';
import 'package:advanced_app/features/Shop/data/models/products_shop/products_shop.dart';
import 'package:advanced_app/features/home/presentation/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shop/presentation/cubit/shop_cubit.dart';

class SlaleWidgetContainer extends StatelessWidget {
  const SlaleWidgetContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        //! list view of Product
        final List<ProductsShop> getProductSale =
            context.read<ShopCubit>().getProductsData;
        if (state is ShopingLoading) {
          return
              // Center(
              //   child: HomWidget(context, getProductSale, 1).redacted(
              //     context: context,
              //     redact: true,
              //     configuration: RedactedConfiguration(
              //       animationDuration:
              //           const Duration(milliseconds: 800), //default
              //     ),
              //   ),
              // );
              const LodingAppList();
        } else if (state is ShopingSuccses) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            primary: true,
            itemCount: getProductSale.length,
            itemBuilder: (BuildContext context, int index) {
              if (getProductSale[index].isSale == true) {
                return BlocConsumer<ShopCubit, ShopState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductDetailsScreen(
                              index: index,
                              products: getProductSale[index],
                              productID: getProductSale[index],
                              // isFavorte: context
                              //     .read<ShopCubit>()
                              //     .chaickIsFavorte(
                              //         getProductSale[index].productId),
                            ),
                          ),
                        );
                      },
                      child: HomWidget(context, getProductSale, index),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          );
        } else {
          return Center(
            child: Column(
              children: [
                const Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4_sharp),
                Text(
                  'No Internet Connection',
                  style: StyleTextApp.font16ColorblacFontWeightBold,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
}
