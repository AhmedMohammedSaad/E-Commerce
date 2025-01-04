// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownButton2 extends StatefulWidget {
  const DropdownButton2({Key? key}) : super(key: key);

  @override
  _DropdownButton2State createState() => _DropdownButton2State();
}

class _DropdownButton2State extends State<DropdownButton2> {
  String? selectedColor = 'Select Color'; // القيمة الافتراضية للنص

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 130.w,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // ظل خفيف لإبراز الكونتينر
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // تأثير الظل
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: Colors.white, // لون الخلفية للقائمة المنسدلة
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
          ),
          hint: Text(
            selectedColor!, // عرض القيمة المختارة بدلاً من النص الثابت
            // تغيير لون النص الافتراضي
          ),
          items: [
            DropdownMenuItem(
              value: "Red",
              child: Text("Red",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            DropdownMenuItem(
              value: "Green",
              child: Text("Green",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            DropdownMenuItem(
              value: "Blue",
              child: Text("Blue",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedColor =
                  value; // تحديث القيمة المختارة وعرضها في الـ DropdownButton
            });
          },
        ),
      ),
    );
  }
}

class DropdownButton1 extends StatefulWidget {
  const DropdownButton1({Key? key}) : super(key: key);

  @override
  _DropdownButton1State createState() => _DropdownButton1State();
}

class _DropdownButton1State extends State<DropdownButton1> {
  String? selectedSize = 'Select Size'; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 130.w,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xffF01F0E),
        ),
        borderRadius: BorderRadius.circular(12), // زوايا دائرية ناعمة
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // ظل خفيف لإبراز الكونتينر
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // تأثير الظل
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true, // أخذ العرض بالكامل
          dropdownColor: Colors.white, // لون الخلفية للقائمة المنسدلة
          icon: Icon(Icons.keyboard_arrow_down_sharp,
              color: Color(0xffF01F0E)), // أيقونة السهم المنسدل بلون الحدود
          hint: Text(
            selectedSize!, // عرض القيمة المحددة بدلاً من النص الثابت
            style: TextStyle(color: Colors.black54), // تغيير لون النص الافتراضي
          ),
          items: [
            DropdownMenuItem(
              value: "Small",
              child: Text("Small",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            DropdownMenuItem(
              value: "Medium",
              child: Text("Medium",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
            DropdownMenuItem(
              value: "Large",
              child: Text("Large",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedSize =
                  value; // تحديث القيمة المختارة وعرضها في الـ DropdownButton
            });
          },
        ),
      ),
    );
  }
}
