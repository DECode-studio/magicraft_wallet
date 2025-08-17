import 'package:magicraft_wallet/controller/page/modal/account.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/button/tab.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../view/key.dart';
import 'action.dart';
import 'network.dart';
import '../view/wallet.dart';

Widget screenPage(
  AccountModalController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                dragAction(controller, size),
                networkButton(controller, size),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      spacing: 30,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0),
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width / 6,
                          ),
                          decoration: customRoundedStyle(
                            color: transparent,
                            borderColor: mainColor_1,
                            isBorder: true,
                          ),
                          child: QrImageView(
                            data: controller.network.value.walletAddress ?? '',
                            foregroundColor: mainColor_1,
                            version: QrVersions.auto,
                            gapless: false,
                          ),
                        ),
                        tabBar(
                          shadow: false,
                          initIndex: controller.tabIndex.value,
                          unSelectedTextColor: purple_3,
                          unSelectedColor: backColor_3,
                          selectedColor: purple_3,
                          borderColor: purple_3,
                          isBorder: true,
                          borderRadius: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          data: ['Wallet', 'Key'],
                          onTap: (index) => controller.actionMethod(
                            mode: 'tab-index',
                            data: index,
                          ),
                        ),
                        controller.loadData.value
                            ? SizedBox(
                                height: size.height * 0.4,
                                child: spinLoad(),
                              )
                            : controller.tabIndex.value == 0
                                ? walletView(controller, size)
                                : controller.tabIndex.value == 1
                                    ? keyView(controller, size)
                                    : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
