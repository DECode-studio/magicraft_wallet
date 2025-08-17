import 'package:dompet_ku/controller/page/main/wallet.dart';
import 'package:dompet_ku/style/color.dart';
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
