import 'package:magicraft_wallet/controller/page/service/auth.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

Widget actionButton(
  AuthPageController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: GetPlatform.isAndroid ? 10 : 30,
        ),
        child: Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: button(
                onClick: controller.cancel,
                isBorder: true,
                isGradient: true,
                borderRadius: 100,
                text: 'Reject',
                color: backColor_2,
                gradientDirection: GradientDirection.horizontal,
              ).animate().fade(duration: 300.ms).scale(delay: 600.ms),
            ),
            Expanded(
              child: button(
                onClick: controller.submit,
                isGradient: true,
                borderRadius: 100,
                text: 'Confirm',
                gradientDirection: GradientDirection.horizontal,
              ).animate().fade(duration: 400.ms).scale(delay: 600.ms),
            ),
          ],
        ),
      ),
    );

Widget dragAction(
  AuthPageController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 30,
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
      ),
    );
