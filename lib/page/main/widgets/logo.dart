import 'package:magicraft_wallet/controller/page/main/main.dart';
import 'package:magicraft_wallet/service/value/wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import 'network.dart';

Widget logoDrawer({
  required MainPageController controller,
  required bool extended,
  required Size size,
}) =>
    Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(
              vertical: controller.drawerController.extended == true ? 30 : 10,
              horizontal: 10,
            ),
            decoration: circleCard(
              color: backColor_2,
              useBorder: true,
              borderColor: purple_1,
              borderSize: 2,
            ),
            child: Image.asset(appIcon),
          ),
          networkButton(controller, size),
          const SizedBox(
            height: 10,
          ),
          Text(
            networkAddress(controller.network.value.chainId ?? ''),
            style: bold_15_2,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => controller.actionMethod(mode: 'copy-address'),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  shortenAddress(controller.network.value.walletAddress ?? ''),
                  style: normal_15_5(color: thirdColor_1),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  HugeIcons.strokeRoundedCopy01,
                  color: white,
                  size: 20,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
