import 'package:dompet_ku/controller/page/main/main.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget fab(
  MainPageController controller,
  Size size,
) =>
    Container(
      decoration: circleShadowCard(
        color: purple_1,
        shadowColor: mainColor_1,
      ),
      child: FloatingActionButton(
        onPressed: () => controller.actionMethod(
          mode: 'change-index',
          data: 2,
        ),
        shape: const CircleBorder(),
        backgroundColor: purple_1,
        child: Icon(
          HugeIcons.strokeRoundedDiscoverCircle,
          color: controller.navIndex.value == 2 ? white : thirdColor_1,
        ),
      ),
    );
