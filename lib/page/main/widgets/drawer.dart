import 'package:dompet_ku/controller/page/main/main.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/drawer.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sidebarx/sidebarx.dart';

import 'logo.dart';

Widget drawerMenu(
  MainPageController controller,
  Size size,
) =>
    SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: customRoundedShadowStyle(
          color: backColor_3,
          shadowColor: mainColor_1,
        ),
        child: SidebarX(
          controller: controller.drawerController,
          showToggleButton: false,
          theme: sideBarTheme(),
          extendedTheme: SidebarXTheme(
            width: 200,
            decoration: customRoundedShadowStyle(color: backColor_3),
          ),
          headerBuilder: (context, extended) => logoDrawer(
            controller: controller,
            extended: extended,
            size: size,
          ),
          items: _mobileMenu(controller),
        ),
      ),
    );

List<SidebarXItem> _mobileMenu(
  MainPageController controller,
) =>
    [
      SidebarXItem(
        icon: HugeIcons.strokeRoundedInformationCircle,
        label: 'Info',
        onTap: () => controller.actionMethod(mode: 'info'),
      ),
      SidebarXItem(
        icon: HugeIcons.strokeRoundedNote,
        label: 'Persyaratan',
        onTap: () => controller.actionMethod(mode: 'terms'),
      ),
      SidebarXItem(
        icon: HugeIcons.strokeRoundedHeadset,
        label: 'Kontak',
        onTap: () => controller.actionMethod(mode: 'contact'),
      ),
      SidebarXItem(
        icon: HugeIcons.strokeRoundedWalletRemove01,
        label: 'Remove Wallet',
        onTap: () => controller.actionMethod(mode: 'remove-wallet'),
      ),
    ];
