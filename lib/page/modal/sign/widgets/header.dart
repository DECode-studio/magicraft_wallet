import 'package:cached_network_image/cached_network_image.dart';
import 'package:magicraft_wallet/controller/page/modal/sign.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget headerPage(
  SignModalController controller,
  Size size,
) =>
    Row(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://excitech-id.my.id/files/images/app/dompet-ku/dompet-ku-icon.png",
          imageBuilder: (_, imageProvider) => Container(
            width: 50,
            height: 50,
            decoration: circleImageCard(
              imageProvider: imageProvider,
              shadow: false,
            ),
          ),
          placeholder: (context, url) => Center(child: customeSpinLoad(30, 30)),
          errorWidget: (context, url, error) => const Center(
            child: Icon(
              HugeIcons.strokeRoundedAlert02,
              color: white,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Magicraft Wallet",
              style: bold_20_2,
            ),
            Text(
              "https://excitech.id/",
              style: normal_15_2,
            ),
          ],
        ),
      ],
    );
