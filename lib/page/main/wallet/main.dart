import 'package:magicraft_wallet/controller/page/main/wallet.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/screen.dart';

class WalletFragment extends StatelessWidget {
  const WalletFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<WalletFragmentController>(
      init: WalletFragmentController(),
      builder: (controller) => Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: transparent,
        body: screenPage(
          controller,
          size,
        ),
      ),
    );
  }
}
