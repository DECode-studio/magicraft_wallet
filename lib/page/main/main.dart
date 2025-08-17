import 'package:magicraft_wallet/controller/page/main/main.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/bottom_bar.dart';
import 'widgets/drawer.dart';
import 'widgets/screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<MainPageController>(
      init: MainPageController(),
      builder: (controller) => DoubleBack(
        onFirstBackPress: (_) => dangerToast("Press back again to close"),
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          key: controller.keyPage.value,
          backgroundColor: backColor_3,
          body: screenPage(controller, size),
          drawer: drawerMenu(controller, size),
          bottomNavigationBar: bottomBar(controller, size),
        ),
      ),
    );
  }
}
