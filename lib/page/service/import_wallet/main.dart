import 'package:magicraft_wallet/controller/page/service/import_wallet.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/screen.dart';
import 'widget/toolbar.dart';

class ImportWalletPage extends StatelessWidget {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<ImportWalletPageController>(
      init: ImportWalletPageController(),
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
