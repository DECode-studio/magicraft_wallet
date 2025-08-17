import 'package:dompet_ku/controller/page/service/info.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/widget/button/button.dart';
import 'package:flutter/material.dart';

Widget actionButton(
  InfoPageController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: button(
          onClick: controller.actionClick,
          isGradient: true,
          borderRadius: 100,
          text: controller.buttonText ?? 'Back',
          gradientDirection: GradientDirection.horizontal,
        ),
      ),
    );
