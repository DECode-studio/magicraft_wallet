import 'package:magicraft_wallet/controller/page/detail/send.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/button/switch.dart';
import 'package:magicraft_wallet/widget/data/text_link.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:magicraft_wallet/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'action.dart';
import 'network.dart';
import 'token.dart';

Widget screenPage(
  SendPageController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    networkButton(controller, size),
                    textBoxTitle(
                      textController: controller.txtFrom,
                      inputType: TextInputType.text,
                      icon: HugeIcons.strokeRoundedBitcoinWallet,
                      title: 'From',
                      hint: 'From Address',
                      radiusSize: 100,
                      backColor: backColor_2,
                      textStyle: normal_15_2,
                      titleStyle: normal_12_2,
                      readOnly: true,
                    ),
                    textBoxTitle(
                        textController: controller.txtTo,
                        inputType: TextInputType.text,
                        icon: HugeIcons.strokeRoundedBitcoinWallet,
                        title: 'To',
                        hint: 'Destination Address',
                        radiusSize: 100,
                        backColor: backColor_2,
                        textStyle: normal_15_2,
                        titleStyle: normal_12_2,
                        actions: [
                          InkWell(
                            onTap: () =>
                                controller.actionMethod(mode: 'bookmark'),
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: customRoundedStyle(
                                size: 100,
                                isBorder: true,
                                color: mainColor_1.withAlpha(100),
                                borderColor: mainColor_1,
                              ),
                              child: Icon(
                                HugeIcons.strokeRoundedCollectionsBookmark,
                                color: white,
                              ),
                            ),
                          )
                        ]),
                    if ((controller.network.value.chainId ?? '')
                            .split(':')
                            .first ==
                        'eip155')
                      titleSwitchButton(
                        title: 'Enable Data Hex',
                        initData: controller.dataHexStatus.value,
                        titleStyle: normal_12_2,
                        dataStyle: normal_15_2,
                        color: thirdColor_1,
                        onChange: (value) => controller.actionMethod(
                          mode: 'data-hex-status',
                          data: value,
                        ),
                      ),
                    textBoxTitle(
                      textController: controller.txtAmount,
                      inputType: TextInputType.number,
                      icon: HugeIcons.strokeRoundedCoins01,
                      title: 'Amount',
                      hint: 'Token Amount',
                      radiusSize: 100,
                      backColor: backColor_2,
                      textStyle: normal_15_2,
                      titleStyle: normal_12_2,
                      readOnly: controller.asset.value.tokenSymbol == null,
                      actions: [
                        tokenkButton(controller, size),
                      ],
                    ),
                    if (controller.asset.value.tokenAddress != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          textLink(
                              onClick: () =>
                                  controller.actionMethod(mode: 'max-amount'),
                              text:
                                  'Balance ${controller.asset.value.tokenBalance ?? 0} ${controller.asset.value.tokenSymbol ?? ''} ',
                              link: 'MAX',
                              textStyle: normal_15_2,
                              linkStyle: bold_15_5(color: thirdColor_1)),
                        ],
                      ),
                    if (controller.dataHexStatus.value)
                      textBoxTitle(
                        textController: controller.txtHex,
                        inputType: TextInputType.text,
                        icon: HugeIcons.strokeRoundedBlockchain01,
                        title: 'HEX Data',
                        hint: 'Input HEX Data',
                        backColor: backColor_2,
                        textStyle: normal_15_2,
                        titleStyle: normal_12_2,
                        lines: 4,
                        minLine: 4,
                      ),
                  ],
                ),
              ),
              actionButton(controller, size),
            ],
          );
