import 'package:dompet_ku/controller/page/main/wallet.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../widgets/token.dart';

Widget viewToken(
  WalletFragmentController controller,
  Size size,
) =>
    Column(
      spacing: 15,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            right: 20,
            left: 20,
          ),
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
          child: ListView.builder(
            // shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.listAsset().length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            itemBuilder: (_, index) => tokenCard(
              controller,
              controller.listAsset()[index],
              size,
            ),
          ),
        )
      ],
    );
