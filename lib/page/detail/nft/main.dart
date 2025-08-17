import 'package:magicraft_wallet/controller/page/detail/nft.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NftPage extends StatelessWidget {
  const NftPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return GetBuilder<NftPageController>(
      init: NftPageController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
      ),
    );
  }
}
