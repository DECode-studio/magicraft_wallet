import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget listLabel({
  required List<String> labels,
  Color? backgroundColor,
  Color? borderColor,
  double? borderSize,
  TextStyle? textStyle,
  EdgeInsets? padding,
  double? radiusSize,
  double? spacing,
  double? runSpacing,
}) =>
    Wrap(
      spacing: spacing ?? 15,
      runSpacing: runSpacing ?? 15,
      direction: Axis.horizontal,
      children: labels
          .map(
            (label) => textLabel(
              text: label,
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              borderSize: borderSize,
              textStyle: textStyle,
              radiusSize: radiusSize,
              padding: padding,
            ),
          )
          .toList(),
    );

Widget textLabel({
  required String text,
  Color? backgroundColor,
  Color? borderColor,
  double? borderSize,
  TextStyle? textStyle,
  EdgeInsets? padding,
  double? radiusSize,
  bool isCenter = false,
}) =>
    Container(
      padding: padding,
      decoration: customRoundedStyle(
        color: backgroundColor ?? mainColor_1,
        size: radiusSize ?? 20,
        borderColor: borderColor,
        borderSize: borderSize,
      ),
      child: isCenter
          ? Center(
              child: Text(
                text,
                softWrap: true,
                style: textStyle ?? normal_15_2,
              ),
            )
          : Text(
              text,
              softWrap: true,
              style: textStyle ?? normal_15_2,
            ),
    );
