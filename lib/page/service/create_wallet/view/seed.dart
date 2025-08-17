import 'package:magicraft_wallet/controller/page/service/create_wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget viewSeedPhrase(
  CreateWalletPageController controller,
  Size size,
) =>
    ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          'Write Down Your Seed Phrase',
          style: bold_18_2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "This is your seed phrase. Write it down on a paper and keep it in a safe place. You'll be asked to re-enter this phrase (in order) on the next step.",
          style: normal_15_2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        GridView.builder(
          itemCount: (controller.seedPhrase.value).split(' ').length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (_, index) => Container(
            decoration: customRoundedStyle(
              color: backColor_2,
              borderColor: mainColor_1,
              isBorder: true,
              size: 15,
              borderSize: 1,
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}. ${(controller.seedPhrase.value).split(' ')[index]}',
              style: normal_15_2,
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        buttonIcon(
          onClick: () => controller.actionMethod(mode: 'copy-key'),
          text: 'Copy',
          icon: HugeIcons.strokeRoundedCopy01,
          color: backColor_3,
          iconColor: thirdColor_1,
          textStyle: bold_15_5(
            color: thirdColor_1,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
