import 'package:magicraft_wallet/controller/page/service/create_wallet.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget toolbar(
  CreateWalletPageController controller,
  Size size,
) =>
    SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: Navigate.back,
            icon: Icon(
              HugeIcons.strokeRoundedArrowLeft01,
              color: thirdColor_1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              'Create New Wallet ',
              style: bold_20_2,
            ),
          ),
        ],
      ),
    );
