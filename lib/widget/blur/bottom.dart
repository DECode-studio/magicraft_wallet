import 'package:flutter/material.dart';
import 'package:dompet_ku/style/color.dart';

Widget bottomBlur(
  Size size, {
  List<Color>? colors,
}) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        height: 70.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 0.6),
            colors: colors ??
                [
                  white.withAlpha(0),
                  white,
                ],
          ),
        ),
      ),
    );
