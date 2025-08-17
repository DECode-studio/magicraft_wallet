import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget spinLoad({
  String? text,
  TextStyle? textStyle,
  Color? color,
  double? size,
}) =>
    Center(
      child: text == null
          ? spinIcon()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spinIcon(size: size, color: color),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: textStyle ?? normal_12_1,
                ),
              ],
            ),
    );

Widget customeSpinLoad(
  double height,
  double width, {
  Color? color,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: Center(
        child: spinIcon(
          size: (height + width) / 2,
          color: color,
        ),
      ),
    );

Widget spinIcon({
  double? size,
  Color? color,
}) =>
    SpinKitFadingCircle(
      color: color ?? secondColor_1,
      size: size ?? 50.0,
    );
