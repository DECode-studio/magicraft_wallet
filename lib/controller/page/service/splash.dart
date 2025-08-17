import 'dart:async';

import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/controller/service/wallet.dart';
import 'package:dompet_ku/page/modal/password/main.dart';
import 'package:dompet_ku/service/function/interface.dart';
import 'package:dompet_ku/service/router/screen.dart';
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

    await WalletAppController.initWalletKit();
    Get.offAllNamed(Screen.MAIN_PAGE_ROUTE);
  }
}
