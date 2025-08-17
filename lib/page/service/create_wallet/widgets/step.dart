import 'package:magicraft_wallet/controller/page/service/create_wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

Widget stepBar(
  CreateWalletPageController controller,
  Size size,
) =>
    EasyStepper(
      activeStep: controller.navIndex.value,
      lineStyle: const LineStyle(
        lineSpace: 1,
        lineWidth: 10,
        lineLength: 100,
        lineThickness: 1,
        lineType: LineType.normal,
        unreachedLineType: LineType.dashed,
        activeLineColor: mainColor_1,
      ),
      internalPadding: 0,
      stepRadius: 11,
      showLoadingAnimation: false,
      showStepBorder: false, 
      steps: [
        EasyStep(
          customStep: Container(
            padding: const EdgeInsets.all(15),
            decoration: circleCard(
              isGradient: controller.navIndex.value >= 0,
              isShadow: controller.navIndex.value >= 0,
              useBorder: true,
              borderColor: mainColor_1,
              color: controller.navIndex.value >= 0 ? null : backColor_2,
              gradientDirection: GradientDirection.horizontal,
            ),
          ),
        ),
        EasyStep(
          customStep: Container(
            padding: const EdgeInsets.all(15),
            decoration: circleCard(
              isGradient: controller.navIndex.value >= 1,
              isShadow: controller.navIndex.value >= 1,
              useBorder: true,
              borderColor: mainColor_1,
              color: controller.navIndex.value >= 1 ? null : backColor_2,
              gradientDirection: GradientDirection.horizontal,
            ),
          ),
        ),
        EasyStep(
          customStep: Container(
            padding: const EdgeInsets.all(15),
            decoration: circleCard(
              isGradient: controller.navIndex.value >= 2,
              isShadow: controller.navIndex.value >= 2,
              useBorder: true,
              borderColor: mainColor_1,
              color: controller.navIndex.value >= 2 ? null : backColor_2,
              gradientDirection: GradientDirection.horizontal,
            ),
          ),
        ),
      ],
    );
