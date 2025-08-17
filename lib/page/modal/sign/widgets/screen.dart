import 'package:dompet_ku/controller/page/modal/sign.dart';
import 'package:dompet_ku/service/enum/wallet.dart';
import 'package:dompet_ku/service/value/wallet.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/load/load.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'data.dart';
import 'header.dart';

Widget screenPage(
  SignModalController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 30,
                ),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      headerPage(controller, size),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        titleRequestType(controller.request?.type ??
                            WalletRequestType.CONFIRMATION),
                        style: bold_25_2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      accountData(controller, size),
                      const SizedBox(
                        height: 20,
                      ),
                      if (controller.request?.type ==
                          WalletRequestType.WALLET_CONNECT)
                        permissionData(controller, size),
                      if (controller.request?.type ==
                          WalletRequestType.SEND_TRANSACTION)
                        transactionData(controller, size),
                      if (controller.request?.type ==
                              WalletRequestType.SIGNATURE ||
                          controller.request?.type ==
                              WalletRequestType.CONFIRMATION)
                        messageData(controller, size),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              dragAction(controller, size),
              actionButton(controller, size),
            ],
          );
