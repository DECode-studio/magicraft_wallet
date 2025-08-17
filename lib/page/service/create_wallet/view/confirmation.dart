import 'package:magicraft_wallet/controller/page/service/create_wallet.dart';
import 'package:magicraft_wallet/service/value/text.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget viewConfirmation(
  CreateWalletPageController controller,
  Size size,
) {
  final words = controller.seedData
      .map((e) => controller.seedPhrase.value.split(' ')[e])
      .toList();

  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    children: [
      Text(
        'Confirm Seed Phrase',
        style: bold_18_2,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Select each word in the order it was presented to you",
        style: normal_15_2,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 30,
      ),
      GridView.builder(
        itemCount: controller.seedInput.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (_, index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: customRoundedStyle(
            color: backColor_2,
            borderColor: mainColor_1,
            isBorder: true,
            size: 15,
            borderSize: 1,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            '${controller.seedInput[index] + 1}. ${safeGet(controller.seedSelected, index)}',
            style: normal_15_2,
          ),
        ),
      ),
      const SizedBox(
        height: 50,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: words
                .sublist(0, 3)
                .map((e) => _buildChip(controller: controller, word: e))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: words
                .sublist(3)
                .map((e) => _buildChip(controller: controller, word: e))
                .toList(),
          ),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      buttonIcon(
        onClick: () => controller.actionMethod(mode: 'reset-seed'),
        text: 'Reset',
        icon: HugeIcons.strokeRoundedRefresh,
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
}

Widget _buildChip({
  required CreateWalletPageController controller,
  required String word,
}) {
  final enable = controller.seedSelected.where((e) => e == word).isEmpty;

  return InkWell(
    onTap: () => !enable
        ? null
        : controller.actionMethod(
            mode: 'add-seed',
            data: word,
          ),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: !enable ? backColor_3 : mainColor_1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        word,
        style: normal_18_2,
      ),
    ),
  );
}
