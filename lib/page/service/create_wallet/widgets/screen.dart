import 'package:dompet_ku/controller/page/service/create_wallet.dart';
import 'package:dompet_ku/widget/load/load.dart';
import 'package:flutter/material.dart';

import '../view/confirmation.dart';
import '../view/password.dart';
import '../view/seed.dart';
import 'action.dart';
import 'step.dart';

Widget screenPage(
  CreateWalletPageController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  stepBar(controller, size),
                  Expanded(
                      child: controller.navIndex.value == 0
                          ? viewPassword(controller, size)
                          : controller.navIndex.value == 1
                              ? viewSeedPhrase(controller, size)
                              : controller.navIndex.value == 2
                                  ? viewConfirmation(controller, size)
                                  : Container()),
                ],
              ),
              actionButton(controller, size),
            ],
          );
