import 'package:flutter/material.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';

Widget horizontalTextIcon({
  required IconData icon,
  String? text,
  TextStyle? textStyle,
  Color? iconColor,
  double? iconSize,
  MainAxisAlignment? axisAlignment,
  Widget? child,
  bool isSingleLine = true,
}) =>
    Row(
      spacing: 5,
      mainAxisAlignment: axisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor ?? black_1,
          size: iconSize ?? 20,
        ),
        Expanded(
          child: child ??
              Text(
                text ?? '',
                style: textStyle ?? normal_15_1,
                maxLines: isSingleLine ? 1 : null,
              ),
        ),
      ],
    );

Widget horizontalTitleTextIcon({
  required IconData icon,
  required String title,
  required String text,
  TextStyle? titleStyle,
  TextStyle? textStyle,
  Color? iconColor,
  double? iconSize,
  MainAxisAlignment? mainAxisAlignment,
  MainAxisAlignment? subAxisAlignment,
}) =>
    Row(
      spacing: 5,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor ?? black_1,
          size: iconSize ?? 20,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment:
                subAxisAlignment ?? MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: titleStyle ?? bold_15_1,
              ),
              Text(
                text,
                style: textStyle ?? normal_15_1,
              ),
            ],
          ),
        ),
      ],
    );
