import 'package:magicraft_wallet/controller/page/main/wallet.dart';
import 'package:magicraft_wallet/page/main/wallet/view/nft.dart';
import 'package:magicraft_wallet/style/color.dart';
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
