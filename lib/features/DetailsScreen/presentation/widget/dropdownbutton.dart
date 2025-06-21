// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:advanced_app/core/color/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownColors extends StatefulWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const DropdownColors({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownColors> createState() => _DropdownColorsState();
}

class _DropdownColorsState extends State<DropdownColors> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        items: [
          DropdownMenuItem<String>(
            value: 'red',
            child: Text("red".tr(), style: const TextStyle(color: AppColors.primaryColor)),
          ),
          DropdownMenuItem<String>(
            value: 'green',
            child: Text("green".tr(), style: const TextStyle(color: AppColors.primaryColor)),
          ),
          DropdownMenuItem<String>(
            value: 'blue',
            child: Text("blue".tr(), style: const TextStyle(color: AppColors.primaryColor)),
          ),
        ],
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedValue = newValue;
            });
            widget.onChanged(newValue);
          }
        },
      ),
    );
  }
}

class DropdownTitle extends StatelessWidget {
  final String title;
  final Color color;

  const DropdownTitle({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class DropdownSizes extends StatefulWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const DropdownSizes({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownSizes> createState() => _DropdownSizesState();
}

class _DropdownSizesState extends State<DropdownSizes> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        items: [
          DropdownMenuItem<String>(
            value: 'S',
            child: Text("small".tr(), style: const TextStyle(color: AppColors.primaryColor)),
          ),
          DropdownMenuItem<String>(
            value: 'M',
            child: Text("medium".tr(), style: const TextStyle(color: AppColors.primaryColor)),
          ),
          DropdownMenuItem<String>(
            value: 'L',
            child: Text("large".tr(), style: const TextStyle(color: AppColors.primaryColor)),
          ),
        ],
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedValue = newValue;
            });
            widget.onChanged(newValue);
          }
        },
      ),
    );
  }
}
