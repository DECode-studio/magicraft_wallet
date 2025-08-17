import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';

Widget blackFill() => Positioned.fill(
      child: Container(
        decoration: customRoundedShadowStyle(
          color: black_1.withAlpha(200),
        ),
      ),
    );
