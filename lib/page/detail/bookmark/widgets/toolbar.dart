import 'package:magicraft_wallet/controller/page/detail/bookmark.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget toolbar(
  BookmarkPageController controller,
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
              'Bookmark Address',
              style: bold_20_2,
            ),
          ),
        ],
      ),
    );
