import 'package:dompet_ku/controller/page/modal/account.dart';
import 'package:dompet_ku/service/value/wallet.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget walletView(
  AccountModalController controller,
  Size size,
) =>
    Column(
      spacing: 10,
      children: [
        Text(
          'ETH Address',
          style: bold_18_2,
        ),
        InkWell(
          onTap: () => controller.actionMethod(
            mode: 'copy-address',
            data: controller.session.value.eth?.walletAddress?.first ?? '',
          ),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                shortenAddress(
                  controller.session.value.eth?.walletAddress?.first ?? '',
                  startChars: 10,
                  endChars: 10,
                ),
                style: normal_18_5(color: thirdColor_1),
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
          height: 20,
        ),
      ],
    );
