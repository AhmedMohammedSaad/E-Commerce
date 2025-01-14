import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/widgets/text_fieald.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFormIconButton extends StatelessWidget {
  const SearchFormIconButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorManager.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(40, 0, 0, 0),
                    spreadRadius: 2,
                    offset: Offset(3, 2),
                    blurRadius: 15,
                  ),
                ],
              ),
              //! this form fieald Search
              child: TextFiealdApp(
                  controller: controller, hintText: 'Search in here'),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          //! this Icons is a Button search
          // Container(
          //   height: 60,
          //   decoration: const BoxDecoration(
          //     color: ColorManager.green,
          //     shape: BoxShape.circle,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color.fromARGB(40, 0, 0, 0),
          //         spreadRadius: 2,
          //         offset: Offset(3, 2),
          //         blurRadius: 15,
          //       ),
          //     ],
          //   ),
          //   child: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.search_sharp,
          //       color: ColorManager.white,
          //       size: 22,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
