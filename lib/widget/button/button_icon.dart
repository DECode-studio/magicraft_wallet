import 'package:magicraft_wallet/style/text.dart';
import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';

Widget buttonIcon({
  required Function()? onClick,
  required IconData icon,
}) =>
    onClick != null
        ? GestureDetector(
            onTap: onClick,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: customRoundedShadowStyle(
                color: mainColor_1,
                size: 10,
              ),
              child: Icon(
                icon,
                color: white,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(7),
            decoration: customRoundedShadowStyle(
              color: mainColor_1,
              size: 10,
            ),
            child: Icon(
              icon,
              color: white,
            ),
          );

Widget circleButtonIcon({
  required Function()? onClick,
  required IconData icon,
  String? text,
  Color? color,
  Color? iconColor,
  TextStyle? textStyle,
  List<Color>? listColor,
  double? width,
  bool isGradient = false,
  bool isBorder = false,
  bool isRatio = false,
  bool isSingleLine = false,
  double? borderRadius = 100,
  Color? borderColor,
  GradientDirection gradientDirection = GradientDirection.vertical,
}) {
  final container = Container(
    padding: const EdgeInsets.all(15),
    decoration: customRoundedStyle(
      color: color ?? mainColor_1,
      size: borderRadius,
      borderColor: borderColor,
      isGradient: isGradient,
      isBorder: isBorder,
      colors: listColor,
      gradientDirection: gradientDirection,
    ),
    child: Center(
      child: Icon(
        icon,
        color: iconColor ?? white,
      ),
    ),
  );

  return InkWell(
    onTap: onClick,
    child: Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isRatio ? AspectRatio(aspectRatio: 1, child: container) : container,
        if (text != null)
          Text(
            text,
            style: textStyle ?? bold_15_2,
            maxLines: isSingleLine == false ? null : 1,
            overflow: isSingleLine == false ? null : TextOverflow.ellipsis,
          ),
      ],
    ),
  );
}
