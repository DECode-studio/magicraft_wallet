import 'package:magicraft_wallet/controller/page/detail/other.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/screen.dart';
import 'widgets/toolbar.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<OtherPageController>(
      init: OtherPageController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backColor_3,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backColor_3,
          toolbarHeight: 66,
          automaticallyImplyLeading: false,
          flexibleSpace: toolbar(controller, size),
        ),
        body: screenPage(
          controller,
          size,
        ),
      ),
    );
  }
}
