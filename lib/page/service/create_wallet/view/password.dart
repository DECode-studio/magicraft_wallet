import 'package:magicraft_wallet/controller/page/service/create_wallet.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/button/check_box.dart';
import 'package:magicraft_wallet/widget/text_field/password_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget viewPassword(
  CreateWalletPageController controller,
  Size size,
) =>
    ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          'Create Password',
          style: bold_18_2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'This password will unlock your Dompet Ku wallet only on this service',
          style: normal_15_2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
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
        ),
        const SizedBox(
          height: 15,
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
        ),
        const SizedBox(
          height: 15,
        ),
        checkBox(
          onChange: (value) => controller.actionMethod(
            mode: 'check-agreement',
            data: value,
          ),
          value: controller.agreementChecked.value,
          text:
              "I understand that Dompet Ku cannot recover this password for me and I agree with all Dompet Ku's ",
          linkText: 'Terms and Condition',
          activeColor: thirdColor_1,
          linkStyle: bold_15_5(
            color: thirdColor_1,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
