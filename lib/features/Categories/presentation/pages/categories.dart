// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:advanced_app/features/Categories/presentation/widgets/detales_widgets.dart';
import 'package:advanced_app/features/home/presentation/widgets/sale_text.dart';
import 'package:flutter/material.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({super.key, required this.categorieName});
  final String categorieName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
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
      ),
    );
  }
}
