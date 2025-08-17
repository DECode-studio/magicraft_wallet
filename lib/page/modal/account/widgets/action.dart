import 'package:dompet_ku/controller/page/modal/account.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';

Widget dragAction(
  AccountModalController controller,
  Size size,
) =>
    Container(
      width: size.width,
      decoration: topRoundedCustomeStyle(
        color: backColor_3,
        size: 35,
      ),
      child: Center(
        child: Container(
          width: 35,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
