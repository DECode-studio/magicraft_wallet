import 'package:dompet_ku/controller/page/modal/token.dart';
import 'package:dompet_ku/model/api/response/asset.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/screen.dart';

Future<AssetModel?> tokenModal() => Get.bottomSheet<AssetModel?>(
      SizedBox(
        height: Get.height * 0.75,
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

class _modalBody extends StatelessWidget {
  const _modalBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<TokenModalController>(
      init: TokenModalController(),
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
