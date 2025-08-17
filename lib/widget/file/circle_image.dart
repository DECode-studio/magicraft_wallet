import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:magicraft_wallet/widget/load/load.dart';

Widget circleImage(
  String imageUrl,
  Size size, {
  double? width,
  double? height,
}) =>
    CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (_, imageProvider) => Container(
        width: width ?? size.width,
        height: height,
        decoration: circleImageCard(imageProvider: imageProvider),
      ),
      placeholder: (context, url) => Center(child: customeSpinLoad(30, 30)),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          HugeIcons.strokeRoundedAlert02,
        ),
      ),
    );
