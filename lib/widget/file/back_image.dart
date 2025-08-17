import 'package:flutter/material.dart';

Widget backMainImage({
  required String asset,
  required Size size,
  AlignmentGeometry alignment = Alignment.center,
}) =>
    Positioned.fill(
      child: Image.asset(
        asset,
        height: size.width >= 1180 ? null : size.height,
        width: size.width >= 1180 ? size.width : null,
        fit: BoxFit.cover,
        alignment: alignment,
      ),
    );

Widget backCustomeImage({
  required String asset,
  required Size size,
  AlignmentGeometry alignment = Alignment.center,
}) =>
    Positioned.fill(
      child: Image.asset(
        asset,
        height: size.width >= 1180 ? null : size.height,
        width: size.width >= 1180 ? size.width : null,
        fit: BoxFit.cover,
      ),
    );

Widget bublePage({
  required String asset,
  required Size size,
  AlignmentGeometry alignment = Alignment.center,
}) =>
    Align(
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: 0.1,
        child: Image.asset(
          asset,
          height: size.height,
          fit: BoxFit.cover,
          alignment: alignment,
        ),
      ),
    );

Widget bigBublePage({
  required String asset,
  required Size size,
  AlignmentGeometry alignment = Alignment.center,
}) =>
    Align(
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: 0.1,
        child: Image.asset(
          asset,
          height: size.height,
          fit: BoxFit.cover,
          alignment: alignment,
        ),
      ),
    );

Widget topBublePage({
  required String asset,
  required Size size,
  AlignmentGeometry alignment = Alignment.center,
}) =>
    Align(
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: 0.1,
        child: Image.asset(
          asset,
          height: size.height,
          fit: BoxFit.cover,
          alignment: alignment,
        ),
      ),
    );
