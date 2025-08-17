import 'package:dompet_ku/controller/page/main/main.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hugeicons/hugeicons.dart';

Widget toolbar(
  MainPageController controller,
  Size size,
) =>
    controller.navIndex.value == 2
        ? Container()
        : SafeArea(
            child: Container(
              width: 70,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: backColor_3,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(100),
                ),
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: secondCombine,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  width: 1,
                ),
              ),
              child: IconButton(
                onPressed: () => controller.actionMethod(mode: 'menu'),
                icon: Icon(
                  HugeIcons.strokeRoundedMenuCollapse,
                  color: white,
                ),
              ),
            ),
          );
