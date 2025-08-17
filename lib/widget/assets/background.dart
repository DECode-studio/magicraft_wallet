import 'package:flutter/material.dart';

import 'images.dart';

Widget backScreen(
  Size size, {
  String? asset,
  int backScreen = 1,
  AlignmentGeometry alignment = Alignment.center,
}) =>
    Positioned.fill(
      child: Image.asset(
        asset ?? (backScreen == 1 ? bgScreen_1 : bgScreen_2),
        height: size.width >= 1180 ? null : size.height,
        width: size.width >= 1180 ? size.width : null,
        fit: BoxFit.cover,
        alignment: alignment,
      ),
    );
