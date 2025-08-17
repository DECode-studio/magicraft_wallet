import 'package:cached_network_image/cached_network_image.dart';
import 'package:magicraft_wallet/controller/page/detail/send.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget tokenkButton(
  SendPageController controller,
  Size size,
) =>
    GestureDetector(
      onTap: () => !controller.dataHexStatus.value
          ? controller.actionMethod(mode: 'search-asset')
          : null,
      child: SizedBox(
        width: size.width / 2.3,
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
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.asset.value.tokenLogo == null ||
                            controller.asset.value.tokenLogo == ""
                        ? 'https://ui-avatars.com/api/?name=${controller.asset.value.tokenName?.replaceAll(RegExp(r'\s+'), '+')}&background=9069FF&color=fff&rounded=true&size=128'
                        : controller.asset.value.tokenLogo ?? "",
                    imageBuilder: (_, imageProvider) => Container(
                      width: 25,
                      height: 25,
                      decoration: circleImageCard(
                        imageProvider: imageProvider,
                        shadowColor: purple_3,
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: customeSpinLoad(15, 15)),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        HugeIcons.strokeRoundedAlert02,
                        color: white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      controller.asset.value.tokenName != null
                          ? '(${controller.asset.value.tokenSymbol}) ${controller.asset.value.tokenName}'
                          : 'Select Token',
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
