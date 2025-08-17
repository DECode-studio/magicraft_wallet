import 'package:flutter/material.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';

Widget blackFill() => Positioned.fill(
      child: Container(
        decoration: customRoundedShadowStyle(
          color: black_1.withAlpha(200),
        ),
      ),
    );
