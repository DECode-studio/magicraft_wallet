import 'package:magicraft_wallet/controller/page/detail/token.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return GetBuilder<TokenPageController>(
      init: TokenPageController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
      ),
    );
  }
}
