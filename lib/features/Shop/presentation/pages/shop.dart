// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:advanced_app/features/Shop/presentation/widgets/grid_view.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/search_fieald_iconbutton.dart';
import 'package:advanced_app/features/home/presentation/widgets/sale_text.dart';
import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchFormIconButton(),
          //! Text title the shop
          SaleText('Shop'),
          //! this is gridVie
          Expanded(
            child: GridviewForWidget(),
          ),
        ],
      ),
    );
  }
}
