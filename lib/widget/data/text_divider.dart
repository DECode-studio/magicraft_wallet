import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget textDivider({
  required String text,
  TextStyle? textStyle,
  Color? dividerColor,
  double? dividerSize,
  double? gapSize,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: dividerSize,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: gapSize ?? 15,
          ),
          child: Text(
            text,
            style: textStyle ?? normal_12_1,
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: dividerSize,
          ),
        ),
      ],
    );
