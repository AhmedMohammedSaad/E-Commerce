import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:flutter/material.dart';

class DivideWidgetComments extends StatelessWidget {
  const DivideWidgetComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 10,
            indent: 10,
          ),
        ),
        Text(
          "Comments",
          style: StyleTextApp.font14ColorblacFontWeightBold,
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}
