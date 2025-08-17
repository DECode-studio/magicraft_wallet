import 'package:dompet_ku/controller/page/service/auth.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget actionButton(
  AuthPageController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            button(
              onClick: () => controller.actionMethod(
                mode: 'import-wallet',
              ),
              isBorder: true,
              isGradient: true,
              borderRadius: 100,
              text: 'Import Existing Wallet',
              color: backColor_2,
              gradientDirection: GradientDirection.horizontal,
            ).animate().fade(duration: 1100.ms).scale(delay: 600.ms),
            button(
              onClick: () => controller.actionMethod(
                mode: 'create-wallet',
              ),
              isGradient: true,
              borderRadius: 100,
              text: 'Create a New Wallet',
              gradientDirection: GradientDirection.horizontal,
            ).animate().fade(duration: 1200.ms).scale(delay: 600.ms),
          ],
        ),
      ),
    );
