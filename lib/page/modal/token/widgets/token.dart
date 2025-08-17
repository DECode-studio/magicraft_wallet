import 'package:cached_network_image/cached_network_image.dart';
import 'package:dompet_ku/controller/page/modal/token.dart';
import 'package:dompet_ku/model/api/response/asset.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/load/load.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget cardData(
  TokenModalController controller,
  AssetModel data,
  Size size,
) =>
    InkWell(
      onTap: () => controller.actionMethod(
        mode: 'select',
        data: data,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: data.tokenLogo != null && data.tokenLogo != ''
                  ? data.tokenLogo ?? ''
                  : 'https://ui-avatars.com/api/?name=${data.tokenName?.replaceAll(RegExp(r'\s+'), '+')}&background=9069FF&color=fff&rounded=true&size=128',
              imageBuilder: (_, imageProvider) => Container(
                width: 45,
                height: 45,
                decoration: circleImageCard(
                  imageProvider: imageProvider,
                  shadowColor: purple_3,
                ),
              ),
              placeholder: (context, url) =>
                  Center(child: customeSpinLoad(30, 30)),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  HugeIcons.strokeRoundedAlert02,
                  color: white,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.tokenName ?? "",
                    style: bold_18_2,
                  ),
                  Text(
                    "${data.tokenBalance ?? 0} ${data.tokenSymbol ?? ''}",
                    style: bold_15_5(color: thirdColor_1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
