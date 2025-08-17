import 'package:magicraft_wallet/controller/page/service/auth.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/screen.dart';

Future<bool> passwordModal() async {
  final result = await Get.bottomSheet<bool>(
    SizedBox(
      height: Get.height <= 600 ? Get.height : Get.height * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: _modalBody(),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: backColor_3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
  );

  return result ?? false;
}

class _modalBody extends StatelessWidget {
  const _modalBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<AuthPageController>(
      init: AuthPageController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backColor_3,
        body: screenPage(
          controller,
          size,
        ),
      ),
    );
  }
}
