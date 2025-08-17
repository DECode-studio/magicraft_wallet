import 'package:magicraft_wallet/controller/page/detail/bookmark.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:magicraft_wallet/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'card.dart';

Widget screenPage(
  BookmarkPageController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: textBoxTitle(
                  textController: controller.txtSearch,
                  inputType: TextInputType.text,
                  icon: HugeIcons.strokeRoundedSearch02,
                  title: 'Search',
                  hint: 'Search here..',
                  radiusSize: 100,
                  backColor: backColor_2,
                  titleStyle: normal_15_2,
                  textStyle: normal_15_2,
                  onChange: (_) => controller.actionMethod(mode: 'search'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Bookmark List',
                      style: bold_15_2,
                    ),
                    const Divider(
                      color: white,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.bookmarkList().length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (_, index) => cardData(
                    controller,
                    controller.bookmarkList()[index],
                    size,
                  ),
                ),
              )
            ],
          );
