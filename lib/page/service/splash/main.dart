import 'package:dompet_ku/controller/page/service/splash.dart';
import 'package:dompet_ku/page/service/splash/wdgets/screen.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<SplashPageController>(
      init: SplashPageController(),
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
