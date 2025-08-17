import 'package:dompet_ku/controller/page/service/auth.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/load/load.dart';
import 'package:dompet_ku/widget/text_field/password_field.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'action.dart';
import 'logo.dart';

Widget screenPage(
  AuthPageController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 30,
                ),
                child: Column(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logoApp(),
                    passwordFieldTitle(
                      textController: controller.txtPassword,
                      icon: HugeIcons.strokeRoundedLockPassword,
                      inputType: TextInputType.visiblePassword,
                      title: 'Password',
                      hint: 'Enter Password',
                      radiusSize: 100,
                      backColor: backColor_2,
                      titleStyle: normal_15_2,
                      textStyle: normal_15_2,
                    ),
                  ],
                ),
              ),
              dragAction(controller, size),
              actionButton(controller, size),
            ],
          );
