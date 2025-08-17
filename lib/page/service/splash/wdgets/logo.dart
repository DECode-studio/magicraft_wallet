import 'package:magicraft_wallet/controller/page/service/splash.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/assets/images.dart';
import 'package:flutter/material.dart';

Widget logoApp(
  SplashPageController controller,
  Size size,
) =>
    Center(
      child: Padding(
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
              'Magicraft Wallet',
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
