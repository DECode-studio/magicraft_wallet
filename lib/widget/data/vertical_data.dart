import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget verticalTextData({
  required String title,
  required String data,
  TextStyle? titleStyle,
  TextStyle? textStyle,
  IconData? icon,
  double? iconSize,
  bool useUnderLine = false,
  Color? underLineColor,
  double? underLineSize,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon != null
                ? Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: iconSize,
                      ),
                      Text(
                        title,
                        style: titleStyle ?? bold_15_1,
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: titleStyle ?? bold_15_1,
                  ),
            useUnderLine
                ? Divider(
                    thickness: underLineSize ?? 1,
                    color: underLineColor ?? black_1,
                  )
                : const SizedBox(
                    height: 5,
                  ),
          ],
        ),
        Text(
          data,
          style: textStyle ?? normal_15_1,
        ),
      ],
    );
