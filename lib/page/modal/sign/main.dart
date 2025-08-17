import 'package:magicraft_wallet/controller/page/modal/sign.dart';
import 'package:magicraft_wallet/model/local/wallet_request.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/screen.dart';

Future<bool> signModal({
  WalletRequestModel? request,
}) async {
  final result = await Get.bottomSheet<bool>(
    SizedBox(
      height: Get.height <= 600 ? Get.height : Get.height * 0.75,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: _modalBody(
          request: request,
        ),
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
  final WalletRequestModel? request;
  const _modalBody({this.request});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<SignModalController>(
      init: SignModalController(request: request),
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
