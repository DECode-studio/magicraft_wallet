import 'package:flutter/material.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';

Widget buttonMenu({
  required IconData icon,
  required String name,
}) =>
    Row(
      children: [
        Icon(
          icon,
          color: mainColor_1,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: normal_15_4,
        )
      ],
    );
