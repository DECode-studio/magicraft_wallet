import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'color.dart';
import 'text.dart';

double borderRadius = 15;

InputDecoration textFieldStyle({
  required String hint,
  IconData? icon,
  Color? borderColor,
  Color? hintColor,
  TextStyle? hintStyle,
  double? radiusSize,
  Widget? suffix,
}) =>
    InputDecoration(
      hintText: hint,
      hintStyle: hintStyle ??
          TextStyle(
            color: hintColor ?? gray_1,
          ),
      prefixIcon: icon == null
          ? null
          : Icon(
              icon,
              color: hintColor ?? gray_1,
            ),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: mainColor_1,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radiusSize ?? borderRadius),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor ?? white,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radiusSize ?? borderRadius),
        ),
      ),
    );

InputDecoration passwordFieldStyle(
  String hint,
  IconData icons,
  bool passVisible, {
  required Function() onTap,
  Color? borderColor,
  Color? hintColor,
  TextStyle? hintStyle,
  double? radiusSize,
}) =>
    InputDecoration(
      hintText: hint,
      hintStyle: hintStyle ??
          TextStyle(
            color: hintColor ?? gray_1,
          ),
      prefixIcon: Icon(
        icons,
        color: hintColor ?? gray_1,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: mainColor_1,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radiusSize ?? borderRadius),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor ?? gray_3,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radiusSize ?? borderRadius),
        ),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          passVisible
              ? HugeIcons.strokeRoundedView
              : HugeIcons.strokeRoundedViewOffSlash,
          color: white,
        ),
        onPressed: onTap,
      ),
    );

InputDecoration searchFieldStyle(
  String hint,
  IconData icons,
) =>
    InputDecoration(
      hintText: hint,
      hintStyle: normal_15_1,
      prefixIcon: Icon(
        icons,
        color: gray_1,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_1,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_3,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
    );

InputDecoration searchFieldStyle_2(
  String hint,
  IconData icons,
) =>
    InputDecoration(
      hintText: hint,
      hintStyle: normal_15_1,
      prefixIcon: Icon(
        icons,
        color: gray_1,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_1,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_3,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
    );

InputDecoration costFieldStyle(
  String hint,
) =>
    InputDecoration(
      hintText: 'Rp $hint',
      hintStyle: normal_15_1,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_1,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_3,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
    );

InputDecoration customFieldStyle(
  String hint, {
  IconData? icons,
  Function()? ontap,
  TextStyle? hintStyle,
}) =>
    InputDecoration(
      hintText: hint,
      hintStyle: hintStyle ?? normal_15_1,
      prefixIcon: icons != null
          ? Icon(
              icons,
              color: mainColor_1,
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_1,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: gray_3,
          width: 0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
    );

var normalInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: gray_3,
    width: 1,
  ),
  borderRadius: const BorderRadius.all(
    Radius.circular(20),
  ),
);
