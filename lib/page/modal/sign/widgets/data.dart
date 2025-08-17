import 'package:magicraft_wallet/controller/page/modal/sign.dart';
import 'package:magicraft_wallet/service/value/wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/data/txt_icon.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget accountData(
  SignModalController controller,
  Size size,
) =>
    Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: customRoundedStyle(
        color: purple_3.withAlpha(100),
        size: 20,
      ),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.network.value.detail?.nameNetwork ?? '',
            style: bold_18_2,
          ),
          Text(
            controller.network.value.walletAddress ?? '',
            style: normal_15_2,
          )
        ],
      ),
    );

Widget messageData(
  SignModalController controller,
  Size size,
) =>
    Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: customRoundedStyle(
        color: purple_3.withAlpha(100),
        size: 20,
      ),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Message",
            style: bold_18_2,
          ),
          Text(
            controller.request?.message ?? '',
            style: normal_15_2,
          )
        ],
      ),
    );

Widget transactionData(
  SignModalController controller,
  Size size,
) =>
    Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: customRoundedStyle(
        color: purple_3.withAlpha(100),
        size: 20,
      ),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "From",
            style: bold_18_2,
          ),
          Text(
            shortenAddress(
              controller.currentNetwork.value.walletAddress ?? '',
              startChars: 12,
              endChars: 12,
            ),
            style: normal_15_2,
            maxLines: 1,
          ),
          Divider(
            color: white,
            thickness: 0.5,
          ),
          Text(
            "To",
            style: bold_18_2,
          ),
          Text(
            shortenAddress(
              controller.toAddress.value,
              startChars: 12,
              endChars: 12,
            ),
            style: normal_15_2,
            maxLines: 1,
          ),
          Divider(
            color: white,
            thickness: 0.5,
          ),
          Text(
            "Amount",
            style: bold_18_2,
          ),
          Text(
            '${controller.amount.value} ${controller.token.value.tokenSymbol ?? ""}',
            style: normal_15_2,
            maxLines: 1,
          ),
        ],
      ),
    );

Widget permissionData(
  SignModalController controller,
  Size size,
) =>
    Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: customRoundedStyle(
        color: purple_3.withAlpha(100),
        size: 20,
      ),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Permission",
            style: bold_18_2,
          ),
          horizontalTextIcon(
            icon: HugeIcons.strokeRoundedCheckmarkCircle03,
            text: 'See your balance and activity',
            iconColor: green,
            textStyle: normal_15_2,
            isSingleLine: false,
          ),
          horizontalTextIcon(
            icon: HugeIcons.strokeRoundedCheckmarkCircle03,
            text: 'Request approval for transactions',
            iconColor: green,
            textStyle: normal_15_2,
            isSingleLine: false,
          ),
          horizontalTextIcon(
            icon: HugeIcons.strokeRoundedCheckmarkCircle03,
            text: 'No asset will be transferred without your confirmation',
            iconColor: green,
            textStyle: normal_15_2,
            isSingleLine: false,
          ),
        ],
      ),
    );
