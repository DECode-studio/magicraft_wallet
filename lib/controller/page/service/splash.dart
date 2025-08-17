import 'dart:async';

import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/controller/service/wallet.dart';
import 'package:magicraft_wallet/page/modal/password/main.dart';
import 'package:magicraft_wallet/service/function/interface.dart';
import 'package:magicraft_wallet/service/router/screen.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  final authApp = AuthAppController();
  final params = Get.parameters;

  @override
  void onInit() {
    super.onInit();

    fullScreenInterface();
    splashTime();
  }

  void splashTime() async {
    Timer(
      const Duration(seconds: 4),
      () async => authRoute(),
    );
  }

  void authRoute() async {
    final session = AuthAppController.getSession();

    if (session.token == null) {
      Get.offAllNamed(Screen.AUTH_PAGE_ROUTE);
      return;
    }

    if (authApp.isJwtExpired()) {
      final res = await passwordModal();
      if (!res) return;
    }

    await WalletAppController.init();
    Get.offAllNamed(Screen.MAIN_PAGE_ROUTE);
  }
}
