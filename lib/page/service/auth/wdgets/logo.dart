import 'package:magicraft_wallet/controller/page/service/auth.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/assets/images.dart';
import 'package:flutter/material.dart';

Widget logoApp(
  AuthPageController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: size.height / 2,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              appIcon,
              height: 150,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Dompet Ku',
              style: normal_25_5(
                color: thirdColor_1,
              ),
            ),
            Text(
              'most secure and reliable\nweb3 wallet',
              style: normal_15_2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
