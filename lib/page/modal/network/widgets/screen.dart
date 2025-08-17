import 'package:magicraft_wallet/controller/page/modal/network.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:magicraft_wallet/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'action.dart';
import 'token.dart';

Widget screenPage(
  NetworkModalController controller,
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
                SizedBox(
                  height: size.height * 0.59,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.networkList().length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (_, index) => cardData(
                      controller,
                      controller.networkList()[index],
                      size,
                    ),
                  ),
                )
              ],
            ),
          );
