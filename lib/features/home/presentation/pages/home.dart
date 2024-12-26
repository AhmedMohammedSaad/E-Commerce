import 'package:advanced_app/core/widgets/appbar.dart';

import 'package:advanced_app/features/home/presentation/widgets/carousel_slider.dart';
import 'package:advanced_app/features/home/presentation/widgets/categores.dart';
import 'package:advanced_app/features/home/presentation/widgets/sale_text.dart';
import 'package:advanced_app/features/home/presentation/widgets/widget_sale_contaire.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Welcome in Brando', leding: false),
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
              child: const ListCategorys(),
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
