import 'package:magicraft_wallet/controller/page/main/wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';

Widget dragAction(
  WalletFragmentController controller,
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
