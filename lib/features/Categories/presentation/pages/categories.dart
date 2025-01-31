// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:advanced_app/features/Categories/presentation/widgets/detales_widgets.dart';
import 'package:advanced_app/features/home/presentation/widgets/sale_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({super.key, required this.categorieName});
  final String categorieName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          //! Text title the Categories
          SaleText('Categories'),
          //! this is gridVie
          Expanded(
            child: CategoriesDetalse(
              categorieName: categorieName,
            ),
          ),
        ],
      ),
    );
  }
}
