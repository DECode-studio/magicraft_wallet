import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dompet_ku/controller/page/main/main.dart';
import 'package:dompet_ku/model/local/menu.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget bottomBar(
  MainPageController controller,
  Size size,
) =>
    AnimatedBottomNavigationBar.builder(
      itemCount: listIcon.length,
      tabBuilder: (int index, bool isActive) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive
                ? listIcon[index].selectedIcon
                : listIcon[index].unSelectedIcon,
            size: 24,
            color: isActive ? white : mainColor_1,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              listIcon[index].textMenu,
              maxLines: 1,
              style: isActive ? bold_12_2 : normal_12_4,
            ),
          )
        ],
      ),
      height: 70,
      elevation: 20,
      shadow: Shadow(color: mainColor_1, blurRadius: 20),
      backgroundColor: purple_1,
      activeIndex: controller.navIndex.value,
      splashColor: mainColor_1,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: controller.navIndex.value == 2 ? 0 : 35,
      rightCornerRadius: controller.navIndex.value == 2 ? 0 : 35,
      onTap: (index) => controller.actionMethod(
        mode: 'change-index',
        data: index,
      ),
    );

var listIcon = [
  BottomBarItemModel(
    selectedIcon: HugeIcons.strokeRoundedWallet02,
    unSelectedIcon: HugeIcons.strokeRoundedWallet02,
    textMenu: 'wallet',
  ),
  BottomBarItemModel(
    selectedIcon: HugeIcons.strokeRoundedTransactionHistory,
    unSelectedIcon: HugeIcons.strokeRoundedTransactionHistory,
    textMenu: 'history',
  ),
];
