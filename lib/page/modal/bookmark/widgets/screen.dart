import 'package:magicraft_wallet/controller/page/modal/bookmark.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';

import '../view/create.dart';
import '../view/select.dart';
import 'action.dart';

Widget screenPage(
  BookmarkModalController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Padding(
            padding: EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                dragAction(controller, size),
                Expanded(
                  child: controller.type.value == 'select'
                      ? viewSelect(controller, size)
                      : viewCreate(controller, size),
                ),
              ],
            ),
          );
