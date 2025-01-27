import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Shop/presentation/pages/search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFormIconButton extends StatefulWidget {
  const SearchFormIconButton({
    super.key,
  });

  @override
  State<SearchFormIconButton> createState() => _SearchFormIconButtonState();
}

class _SearchFormIconButtonState extends State<SearchFormIconButton> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 12.h),
      //! this row for search  and icon search
      child: Row(
        children: [
          Expanded(
            //!this container for add style to form fieled
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    bottomLeft: Radius.circular(22)),
                color: ColorManager.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(9, 0, 0, 0),
                    spreadRadius: 2,
                    offset: Offset(3, 2),
                    blurRadius: 15,
                  ),
                ],
              ),
              //! this form fieald Search
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  suffixIconColor: ColorManager.green,
                  hintText: 'Search in Products',
                  hintStyle: StyleTextApp.font14Colorgrayofwite,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorManager.green,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This Field is required';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          //! this Icons is a Button search
          Container(
            height: 56,
            decoration: const BoxDecoration(
              color: ColorManager.green,
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(22),
                  bottomRight: Radius.circular(22)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(40, 0, 0, 0),
                  spreadRadius: 2,
                  offset: Offset(3, 2),
                  blurRadius: 15,
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Search(quary: controller.text)));
              },
              icon: const Icon(
                Icons.search_sharp,
                color: ColorManager.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose;
    super.dispose();
  }
}
