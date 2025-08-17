import 'package:magicraft_wallet/controller/page/service/info.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/assets/background.dart';
import 'package:magicraft_wallet/widget/assets/images.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';

import 'action.dart';

Widget screenPage(
  InfoPageController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Stack(
            children: [
              backScreen(size),
              backScreen(size, asset: bgPattern),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 100,
                  ),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (controller.icon != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Icon(
                            controller.icon,
                            size: 80,
                            color: mainColor_1,
                          ),
                        ),
                      if (controller.imageAsset != null)
                        Image.asset(
                          controller.imageAsset ?? '',
                          height: 250,
                          width: 250,
                        ),
                      if (controller.title != null)
                        Text(
                          controller.title ?? '',
                          style: bold_18_2,
                          textAlign: TextAlign.center,
                        ),
                      if (controller.description != null)
                        Text(
                          controller.description ?? '',
                          style: normal_15_2,
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),
              actionButton(
                controller,
                size,
              )
            ],
          );
