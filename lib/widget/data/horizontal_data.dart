import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget horizontalData({
  required IconData icon,
  String? title,
  required String data,
  Color? colorIcon,
  double? sizeIcon,
  TextStyle? titleStyle,
  TextStyle? dataStyle,
}) =>
    Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: colorIcon ?? black_1,
          size: sizeIcon ?? 15,
        ),
        if (title != null)
          Text(
            title,
            style: titleStyle ?? bold_15_1,
          ),
        Expanded(
          child: Text(
            data,
            style: dataStyle ?? normal_15_1,
          ),
        ),
      ],
    );
