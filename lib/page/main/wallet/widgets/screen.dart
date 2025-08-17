import 'package:magicraft_wallet/controller/page/main/wallet.dart';
import 'package:magicraft_wallet/page/main/wallet/widgets/network.dart';
import 'package:magicraft_wallet/service/formater/balance.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/button/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import 'action.dart';
import 'bar.dart';

Widget screenPage(
  WalletFragmentController controller,
  Size size,
) =>
    SnappingSheet(
      grabbingHeight: 30,
      grabbing: dragAction(controller, size),
      initialSnappingPosition: SnappingPosition.factor(
        grabbingContentOffset: GrabbingContentOffset.bottom,
        snappingCurve: Curves.easeInExpo,
        snappingDuration: Duration(seconds: 1),
        positionFactor: 0.55,
      ),
      snappingPositions: const [
        SnappingPosition.factor(
          positionFactor: 0.55,
          snappingCurve: Curves.easeInExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.bottom,
        ),
        SnappingPosition.factor(
          positionFactor: 0.55,
          snappingCurve: Curves.easeInExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.bottom,
        ),
        SnappingPosition.factor(
          positionFactor: 0.9,
          snappingCurve: Curves.easeInExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.bottom,
        ),
      ],
      sheetBelow: SnappingSheetContent(
        draggable: true,
        sizeBehavior: SheetSizeFill(),
        child: barView(controller, size),
      ),
      child: actionBar(controller, size),
    );

Widget actionBar(
  WalletFragmentController controller,
  Size size,
) =>
    Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: size.height * 0.45,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Available balance',
                style: normal_18_2,
              ),
              Text(
                formatBalance(
                  symbol: controller.asset.value.symbol ?? 'ETH',
                  amount: controller.asset.value.balance ?? 0,
                ),
                style: bold_35_5(
                  color: purple_3,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              networkButton(controller, size),
              const SizedBox(
                height: 30,
              ),
              Row(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  circleButtonIcon(
                    onClick: () => controller.actionMethod(mode: 'send'),
                    icon: HugeIcons.strokeRoundedSent,
                    text: 'Send',
                    isBorder: true,
                    color: transparent,
                    iconColor: thirdColor_1,
                    borderColor: white,
                  ),
                  circleButtonIcon(
                    onClick: () => controller.actionMethod(mode: 'account'),
                    icon: HugeIcons.strokeRoundedQrCode,
                    text: 'Account',
                    isBorder: true,
                    color: transparent,
                    iconColor: thirdColor_1,
                    borderColor: white,
                  ),
                  circleButtonIcon(
                    onClick: () => controller.actionMethod(mode: 'bookmark'),
                    icon: HugeIcons.strokeRoundedBookmark03,
                    text: 'Bookmark',
                    isBorder: true,
                    color: transparent,
                    iconColor: thirdColor_1,
                    borderColor: white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
