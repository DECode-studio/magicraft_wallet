import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:dompet_ku/widget/load/load.dart';

Widget roundedImage(
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
        decoration: customeImageCardStyle(
          imageProvider: imageProvider,
          fit: BoxFit.cover,
          shadow: false,
        ),
      ),
      placeholder: (context, url) => Center(child: customeSpinLoad(30, 30)),
      errorWidget: (context, url, error) => Center(
        child: Icon(
          HugeIcons.strokeRoundedAlert02,
          color: mainColor_1,
        ),
      ),
    );
