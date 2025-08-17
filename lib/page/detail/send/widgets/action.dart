import 'package:magicraft_wallet/controller/page/detail/send.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget actionButton(
  SendPageController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: buttonIcon(
          onClick: controller.validate,
          isGradient: true,
          borderRadius: 100,
          icon: HugeIcons.strokeRoundedSent,
          text: 'Send',
          gradientDirection: GradientDirection.horizontal,
        ),
      ),
    );
