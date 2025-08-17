import 'package:magicraft_wallet/controller/page/detail/other.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/button/button_icon.dart';
import 'package:magicraft_wallet/widget/load/load.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

Widget screenPage(
  OtherPageController controller,
  Size size,
) =>
    controller.loadData.value
        ? spinLoad()
        : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // jumlah kolom per baris
              crossAxisSpacing: 1.0, // jarak horizontal antar item
              mainAxisSpacing: 1.0, // jarak vertikal antar item
              childAspectRatio: 1 / 1.5, // rasio lebar : tinggi
            ),
            itemCount: listMenu().length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: circleButtonIcon(
                onClick: () => controller.actionMethod(
                  mode: listMenu()[index].actionMethod,
                ),
                icon: listMenu()[index].iconMenu,
                text: listMenu()[index].textMenu,
                isBorder: true,
                isRatio: true,
                isSingleLine: true,
                color: transparent,
                iconColor: thirdColor_1,
                borderColor: white,
              ),
            ),
          );
