import 'package:flutter/material.dart';

Widget topBlur(
  Size size, {
  List<Color>? colors,
}) =>
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: size.width,
        height: 100.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.0, -1.0),
            end: const Alignment(0.0, 0.6),
            colors: colors ??
                [
                  Color(0xffffffff),
                  Color(0x00ffffff),
                ],
          ),
        ),
      ),
    );
