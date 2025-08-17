import 'package:dompet_ku/controller/page/main/history.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/load/load.dart';
import 'package:dompet_ku/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'card.dart';
import 'network.dart';

Widget screenPage(
  HistoryFragmentController controller,
  Size size,
) =>
    Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: networkButton(controller, size),
        ),
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
        Expanded(
          child: controller.loadData.value
              ? spinLoad()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.historyList().length,
                  itemBuilder: (_, index) => cardData(
                    controller,
                    controller.historyList()[index],
                    size,
                  ),
                ),
        ),
        const SizedBox(
          height: 85,
        )
      ],
    );
