import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/features/home/presentation/widgets/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Welcome Back!', leding: false),
      body: const Column(
        children: [
          CarouselSliderWidget(),
        ],
      ),
    );
  }
}
