import 'package:cached_network_image/cached_network_image.dart';
import 'package:magicraft_wallet/controller/page/modal/network.dart';
import 'package:magicraft_wallet/model/api/response/network.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget cardData(
  NetworkModalController controller,
  NetworkModel data,
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
              imageUrl:
                  'https://ui-avatars.com/api/?name=${data.nameNetwork?.replaceAll(RegExp(r'\s+'), '+')}&background=9069FF&color=fff&rounded=true&size=128',
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
                    data.nameNetwork ?? "",
                    style: bold_18_2,
                  ),
                  Text(
                    data.chainId ?? "",
                    style: bold_15_5(color: thirdColor_1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
