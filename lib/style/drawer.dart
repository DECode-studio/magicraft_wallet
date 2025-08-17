import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

final canvasColor = purple_1;
final scaffoldBackgroundColor = thirdColor_1;
final accentCanvasColor = mainColor_1;
final actionColor = purple_1.withOpacity(0.6);

SidebarXTheme sideBarTheme() => SidebarXTheme(
      decoration: customRoundedShadowStyle(
        color: purple_1,
        shadowColor: mainColor_1,
      ),
      hoverColor: scaffoldBackgroundColor,
      hoverTextStyle: normal_12_4,
      textStyle: normal_12_2.apply(color: white.withOpacity(0.7)),
      selectedTextStyle: bold_12_2,
      itemTextPadding: const EdgeInsets.only(left: 30),
      selectedItemTextPadding: const EdgeInsets.only(left: 30),
      itemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: canvasColor),
      ),
      selectedItemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: actionColor.withOpacity(0.37),
        ),
        gradient: LinearGradient(
          colors: mainCombine,
        ),
        boxShadow: [
          BoxShadow(
            color: black_1.withOpacity(0.28),
            blurRadius: 30,
          )
        ],
      ),
      iconTheme: IconThemeData(
        color: white.withOpacity(0.7),
        size: 20,
      ),
      selectedIconTheme: IconThemeData(
        color: white,
        size: 20,
      ),
    );
