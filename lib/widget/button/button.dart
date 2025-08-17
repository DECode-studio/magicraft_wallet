import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget button({
  required Function() onClick,
  required String text,
  Color? color,
  TextStyle? textStyle,
  List<Color>? listColor,
  double? width,
  bool isGradient = false,
  bool isShadow = false,
  bool isBorder = false,
  double? borderRadius,
  Color? borderColor,
  GradientDirection gradientDirection = GradientDirection.vertical,
}) =>
    Container(
      width: width ?? Get.width,
      padding: GetPlatform.isMobile
          ? null
          : const EdgeInsets.symmetric(vertical: 10),
      decoration: isShadow == false
          ? customRoundedStyle(
              color: color ?? mainColor_1,
              size: borderRadius,
              borderColor: borderColor,
              isGradient: isGradient,
              isBorder: isBorder,
              colors: listColor,
              gradientDirection: gradientDirection,
            )
          : customRoundedShadowStyle(
              color: color ?? mainColor_1,
              size: borderRadius,
              borderColor: borderColor,
              isGradient: isGradient,
              isBorder: isBorder,
              colors: listColor,
              gradientDirection: gradientDirection,
            ),
      child: TextButton(
        onPressed: onClick,
        child: Text(text, style: textStyle ?? bold_15_2),
      ),
    );

Widget buttonIcon({
  required Function() onClick,
  required String text,
  required IconData icon,
  Color? color,
  Color? iconColor,
  TextStyle? textStyle,
  List<Color>? listColor,
  double? width,
  bool isGradient = false,
  bool shadow = false,
  bool isBorder = false,
  double? borderRadius,
  Color? borderColor,
  GradientDirection gradientDirection = GradientDirection.vertical,
}) =>
    Container(
      width: width ?? Get.width,
      padding: GetPlatform.isMobile
          ? null
          : const EdgeInsets.symmetric(vertical: 10),
      decoration: shadow == false
          ? customRoundedStyle(
              color: color ?? mainColor_1,
              size: borderRadius,
              borderColor: borderColor,
              isGradient: isGradient,
              isBorder: isBorder,
              colors: listColor,
              gradientDirection: gradientDirection,
            )
          : customRoundedShadowStyle(
              color: color ?? mainColor_1,
              size: borderRadius,
              borderColor: borderColor,
              isGradient: isGradient,
              isBorder: isBorder,
              colors: listColor,
              gradientDirection: gradientDirection,
            ),
      child: TextButton.icon(
        onPressed: onClick,
        icon: Icon(icon, color: iconColor ?? white),
        label: Text(text, style: textStyle ?? bold_15_2),
      ),
    );
