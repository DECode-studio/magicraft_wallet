import 'package:dompet_ku/controller/page/service/info.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/screen.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<InfoPageController>(
      init: InfoPageController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        body: screenPage(
          controller,
          size,
        ),
      ),
    );
  }
}
