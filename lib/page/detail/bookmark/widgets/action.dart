import 'package:dompet_ku/controller/page/detail/bookmark.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget actionButton(
  BookmarkPageController controller,
  Size size,
) =>
    FloatingActionButton(
      onPressed: () => controller.actionMethod(mode: 'add'),
      backgroundColor: thirdColor_1,
      child: Icon(
        HugeIcons.strokeRoundedPlusSign,
        color: white,
      ),
    );
