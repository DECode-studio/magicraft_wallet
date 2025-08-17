import 'package:magicraft_wallet/controller/page/main/main.dart';
import 'package:magicraft_wallet/widget/assets/background.dart';
import 'package:flutter/material.dart';

import '../history/main.dart';
import '../wallet/main.dart';
import 'toolbar.dart';

Widget screenPage(
  MainPageController controller,
  Size size,
) =>
    Stack(
      children: [
        backScreen(size, backScreen: 2),
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: controller.navIndex.value == 0
                    ? const WalletFragment()
                    : controller.navIndex.value == 1
                        ? const HistoryFragment()
                        : Container(),
              ),
            ],
          ),
        ),
        toolbar(controller, size),
      ],
    );
