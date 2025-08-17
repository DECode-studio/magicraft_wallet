import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget textData({
  required String title,
  String? data,
  Widget? child,
  TextStyle? titleStyle,
  TextStyle? textStyle,
  bool useUnderLine = false,
  Color? underLineColor,
  double? underLineSize,
  bool isSingleLine = true,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? bold_15_1,
          maxLines: 1,
        ),
        useUnderLine
            ? Divider(
                thickness: underLineSize ?? 1,
                color: underLineColor ?? black_1,
              )
            : const SizedBox(
                height: 5,
              ),
        data == null
            ? Container()
            : Text(
                data,
                style: textStyle ?? normal_15_1,
                maxLines: isSingleLine ? 1 : null,
              ),
        child ?? Container(),
      ],
    );

Widget textDataPadding({
  required String title,
  required String data,
  EdgeInsetsGeometry? padding,
  TextStyle? titleStyle,
  TextStyle? textStyle,
  bool useUnderLine = false,
  Color? underLineColor,
  double? underLineSize,
}) =>
    Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? normal_12_2,
          ),
          useUnderLine
              ? Divider(
                  thickness: underLineSize ?? 1,
                  color: underLineColor ?? black_1,
                )
              : const SizedBox(
                  height: 5,
                ),
          Text(
            data,
            style: textStyle ?? bold_18_2,
          ),
        ],
      ),
    );
