import 'package:advanced_app/core/widgets/appbar.dart';

import 'package:advanced_app/features/home/presentation/widgets/carousel_slider.dart';
import 'package:advanced_app/features/home/presentation/widgets/categores.dart';
import 'package:advanced_app/features/home/presentation/widgets/sale_text.dart';
import 'package:advanced_app/features/home/presentation/widgets/widget_sale_contaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Welcome in Brando', leding: false),
      body: ListView(
        children: [
          //! Carousel Slider Containers
          const CarouselSliderWidget(),

          //! Sale widget text
          SaleText('Categories'),
          //! Categories widgets
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: const ListCategorys(),
          ),
          //! Sale widget text
          SaleText('Sale'),
          //! Widgets image Sale Container

          const SlaleWidgetContainer(),
        ],
      ),
    );
  }
}
