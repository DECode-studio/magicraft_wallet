import 'package:magicraft_wallet/controller/page/main/wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget networkButton(
  WalletFragmentController controller,
  Size size,
) =>
    GestureDetector(
      onTap: () => controller.actionMethod(mode: 'network'),
      child: SizedBox(
        width: size.width / 2.5,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: customRoundedStyle(
                size: 100,
                isBorder: true,
                color: mainColor_1.withAlpha(100),
                borderColor: mainColor_1,
              ),
              child: Row(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    HugeIcons.strokeRoundedBlockchain06,
                    color: white,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(
                      controller.network.value.detail?.nameNetwork ?? '',
                      style: normal_15_2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Icon(
                  HugeIcons.strokeRoundedArrowDown01,
                  color: white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
