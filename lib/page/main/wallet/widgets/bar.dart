import 'package:magicraft_wallet/controller/page/main/wallet.dart';
import 'package:magicraft_wallet/page/main/wallet/view/nft.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/button/tab.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';

import '../view/token.dart';

Widget barView(
  WalletFragmentController controller,
  Size size,
) =>
    Container(
      height: size.height,
      color: backColor_3,
      child: Column(
        children: [
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
            data: ['Token', 'NFt'],
            onTap: (index) => controller.actionMethod(
              mode: 'tab-index',
              data: index,
            ),
          ),
          Expanded(
            child: controller.loadData.value
                ? SizedBox(
                    height: size.height * 0.4,
                    child: spinLoad(),
                  )
                : controller.tabIndex.value == 0
                    ? viewToken(controller, size)
                    : controller.tabIndex.value == 3
                        ? viewNft(controller, size)
                        : Container(),
          )
        ],
      ),
    );
