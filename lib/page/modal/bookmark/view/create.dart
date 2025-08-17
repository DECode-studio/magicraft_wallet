import 'package:dompet_ku/controller/page/modal/bookmark.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/button/button.dart';
import 'package:dompet_ku/widget/button/dropdown.dart';
import 'package:dompet_ku/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget viewCreate(
  BookmarkModalController controller,
  Size size,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.type.value == 'add-address' ||
              controller.type.value == 'add-url')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Add Bookmark',
                  style: bold_18_2,
                ),
                Divider(
                  color: white,
                  endIndent: size.width / 2,
                ),
              ],
            ),
          if (controller.type.value == 'add-address')
            titleDropdown(
              data: controller.listNamespace,
              initialData: controller.txtNameSpace.text,
              hint: 'Chain',
              icon: HugeIcons.strokeRoundedBlockchain06,
              backColor: backColor_2,
              titleStyle: normal_15_2,
              textStyle: normal_15_2,
              borderColor: white,
              radiusSize: 100,
              onChanged: (value) => controller.actionMethod(
                mode: 'set-chain',
                data: value,
              ),
            ),
          textBoxTitle(
            textController: controller.txtLabel,
            inputType: TextInputType.text,
            icon: HugeIcons.strokeRoundedLabelImportant,
            title: 'Label',
            hint: 'Input label...',
            radiusSize: 100,
            backColor: backColor_2,
            titleStyle: normal_15_2,
            textStyle: normal_15_2,
          ),
          if (controller.type.value == 'add-address')
            textBoxTitle(
              textController: controller.txtWallet,
              inputType: TextInputType.text,
              icon: HugeIcons.strokeRoundedWallet01,
              title: 'Wallet Address',
              hint: 'Input wallet address...',
              radiusSize: 100,
              backColor: backColor_2,
              titleStyle: normal_15_2,
              textStyle: normal_15_2,
            ),
          if (controller.type.value == 'add-url')
            textBoxTitle(
              textController: controller.txtUrl,
              inputType: TextInputType.text,
              icon: HugeIcons.strokeRoundedLink02,
              title: 'Url Address',
              hint: 'Input url address...',
              radiusSize: 100,
              backColor: backColor_2,
              titleStyle: normal_15_2,
              textStyle: normal_15_2,
            ),
          const Spacer(),
          button(
            onClick: controller.valudate,
            isGradient: true,
            borderRadius: 100,
            text: 'Add',
            gradientDirection: GradientDirection.horizontal,
          ),
          Container(),
        ],
      ),
    );
