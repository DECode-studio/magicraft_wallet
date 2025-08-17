import 'package:magicraft_wallet/controller/page/service/create_wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/widget/button/button.dart';
import 'package:flutter/material.dart';

Widget actionButton(
  CreateWalletPageController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: button(
          onClick: () => controller.actionMethod(
            mode: 'submit',
          ),
          isGradient: true,
          borderRadius: 100,
          text: controller.navIndex.value < 2 ? 'Next' : 'Confirm',
          gradientDirection: GradientDirection.horizontal,
        ),
      ),
    );
