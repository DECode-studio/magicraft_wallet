import 'package:dompet_ku/controller/page/modal/sign.dart';
import 'package:dompet_ku/service/enum/wallet.dart';
import 'package:dompet_ku/service/value/wallet.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

Widget actionButton(
  SignModalController controller,
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
                onClick: controller.reject,
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
                onClick: controller.confirm,
                isGradient: true,
                borderRadius: 100,
                text: actionRequestType(
                  controller.request?.type ?? WalletRequestType.CONFIRMATION,
                ),
                gradientDirection: GradientDirection.horizontal,
              ).animate().fade(duration: 400.ms).scale(delay: 600.ms),
            ),
          ],
        ),
      ),
    );

Widget dragAction(
  SignModalController controller,
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
