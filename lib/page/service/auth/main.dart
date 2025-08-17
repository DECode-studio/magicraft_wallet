import 'package:dompet_ku/controller/page/service/auth.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wdgets/screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<AuthPageController>(
      init: AuthPageController(),
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
