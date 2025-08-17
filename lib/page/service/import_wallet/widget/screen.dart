import 'package:magicraft_wallet/controller/page/service/import_wallet.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/button/button.dart';
import 'package:magicraft_wallet/widget/button/check_box.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:magicraft_wallet/widget/text_field/password_field.dart';
import 'package:magicraft_wallet/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget screenPage(
  ImportWalletPageController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              spacing: 15,
              children: [
                textBoxTitle(
                  textController: controller.hideData.value
                      ? TextEditingController(
                          text: controller.txtKey.text
                              .split(' ')
                              .map((_) => '●●●●')
                              .join(' '))
                      : controller.txtKey,
                  inputType: TextInputType.text,
                  title: 'Seed Phrase',
                  hint: 'Seed Phrase',
                  backColor: backColor_2,
                  titleStyle: normal_15_2,
                  textStyle: normal_15_2,
                  lines: 4,
                  minLine: 4,
                  onTap: () => controller.actionMethod(
                    mode: 'config-data',
                    data: false,
                  ),
                  onTapOutside: (_) => controller.actionMethod(
                    mode: 'config-data',
                    data: controller.txtKey.text.isNotEmpty,
                  ),
                  onSubmit: (_) => controller.actionMethod(
                    mode: 'config-data',
                    data: controller.txtKey.text.isNotEmpty,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        HugeIcons.strokeRoundedFingerPrintScan,
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
                ),
                passwordFieldTitle(
                  textController: controller.txtPassword,
                  icon: HugeIcons.strokeRoundedLockPassword,
                  inputType: TextInputType.visiblePassword,
                  hint: 'New Password',
                  radiusSize: 100,
                  backColor: backColor_2,
                  titleStyle: normal_15_2,
                  textStyle: normal_15_2,
                  onTap: () => controller.actionMethod(
                    mode: 'config-data',
                    data: controller.txtKey.text.isNotEmpty,
                  ),
                ),
                passwordFieldTitle(
                  textController: controller.txtConfirmPassword,
                  icon: HugeIcons.strokeRoundedLockPassword,
                  inputType: TextInputType.visiblePassword,
                  hint: 'Confirm Password',
                  radiusSize: 100,
                  backColor: backColor_2,
                  titleStyle: normal_15_2,
                  textStyle: normal_15_2,
                  onTap: () => controller.actionMethod(
                    mode: 'config-data',
                    data: controller.txtKey.text.isNotEmpty,
                  ),
                ),
                checkBox(
                  onChange: (value) => controller.actionMethod(
                    mode: 'check-agreement',
                    data: value,
                  ),
                  value: controller.agreementChecked.value,
                  text:
                      "I understand that Magicraft Wallet cannot recover this password for me and I agree with all Magicraft Wallet's ",
                  linkText: 'Terms and Condition',
                  activeColor: thirdColor_1,
                  linkStyle: bold_15_5(
                    color: thirdColor_1,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: button(
                    onClick: controller.validate,
                    isGradient: true,
                    borderRadius: 100,
                    text: 'Import',
                    gradientDirection: GradientDirection.horizontal,
                  ),
                )
              ],
            ),
          );
