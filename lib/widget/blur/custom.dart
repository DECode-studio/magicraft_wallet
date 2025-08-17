import 'package:flutter/material.dart';

Widget topCustomeBlur(
  Size size,
  List<Color> data, {
  double? height,
}) =>
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: size.width,
        height: height ?? 100.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.0, -1.0),
            end: const Alignment(0.0, 0.6),
            colors: data,
          ),
        ),
      ),
    );

Widget bottomCustomBlur(
  Size size,
  List<Color> data, {
  double? height,
}) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        height: height ?? 70.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.0, -1.0),
            end: const Alignment(0.0, 0.6),
            colors: data,
          ),
        ),
      ),
    );
