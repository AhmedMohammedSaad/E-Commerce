import 'package:advanced_app/core/widgets/appbar.dart';
import 'package:advanced_app/features/Shop/presentation/widgets/grid_view.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.quary});
  final String quary;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(leding: true, title: "Search"),
      body: GridviewForWidget(
        quary: widget.quary,
      ),
    );
  }
}
