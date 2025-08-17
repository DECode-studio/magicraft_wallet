import 'package:dompet_ku/controller/page/modal/account.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget keyView(
  AccountModalController controller,
  Size size,
) =>
    Column(
      spacing: 20,
      children: [
        _fieldKey(
          controller: controller,
          textController: controller.txtKey,
          text: 'Seed Phrase',
          size: size,
        ),
        _fieldKey(
          controller: controller,
          textController: controller.txtEth,
          text: 'ETH Private Key',
          size: size,
        ),
      ],
    );

Widget _fieldKey({
  required AccountModalController controller,
  required TextEditingController textController,
  required String text,
  required Size size,
}) =>
    textBoxTitle(
      textController: controller.hideData.value
          ? TextEditingController(
              text: textController.text.split(' ').map((_) => '●●●●').join(' '),
            )
          : textController,
      inputType: TextInputType.text,
      title: text,
      hint: text,
      backColor: backColor_2,
      titleStyle: normal_15_2,
      textStyle: normal_15_2,
      lines: text.toLowerCase() == 'seed phrase' ? 4 : null,
      minLine: text.toLowerCase() == 'seed phrase' ? 4 : null,
      actions: [
        if (controller.hideData.value == false)
          IconButton(
            onPressed: () => controller.actionMethod(
              mode: 'copy-address',
              data: textController.text,
            ),
            icon: Icon(
              HugeIcons.strokeRoundedCopy02,
              color: white,
            ),
          ),
        IconButton(
          onPressed: () => controller.actionMethod(
            mode: 'config-data',
          ),
          icon: Icon(
            controller.hideData.value
                ? HugeIcons.strokeRoundedView
                : HugeIcons.strokeRoundedViewOffSlash,
            color: white,
          ),
        ),
      ],
    );
