import 'package:magicraft_wallet/controller/data/api/auth.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/service/router/screen.dart';
import 'package:magicraft_wallet/service/value/encrypt.dart';
import 'package:magicraft_wallet/widget/load/modal.dart';
import 'package:magicraft_wallet/widget/message/dialogue_box.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class AuthPageController extends GetxController {
  final authApp = AuthAppController();
  final authData = AuthDataController();

  final encrypt = EncryptValue();
  final argument = Get.arguments;

  var session = SessionModel().obs;
  var txtPassword = TextEditingController();

  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    loadData.value = true;
    session.value = AuthAppController.getSession();
    loadData.value = false;
  }

  void actionMethod({
    required String mode,
    dynamic data,
  }) async {
    if (mode == 'import-wallet') {
      await Get.toNamed(Screen.IMPORT_WALLET_PAGE_ROUTE);
    }

    if (mode == 'create-wallet') {
      loadModal();
      await Get.toNamed(Screen.CREATE_WALLET_PAGE_ROUTE)?.then(
        (_) => Navigate.back(),
      );
    }
  }

  void submit() async {
    if (encrypt.encryptData(txtPassword.text) != session.value.password) {
      dangerToast('Your password is wrong or invalid!');
      return;
    }

    loadModal();
    final res = await authData.ethVerify();
    if (res.token == null) {
      dangerToast('Process error!\nPlease, try again!');
      Navigate.back();

      return;
    }

    Navigate.back();
    Get.back(result: true);
  }

  void cancel() {
    Get.back(result: false);
  }

  void remove() async {
    dialogueBox(
      icon: HugeIcons.strokeRoundedInformationCircle,
      title: 'Are you sure?',
      description: 'you can not recover your current wallet account.',
      actions: ['no', 'yes'],
      isBottomSheet: true,
      onAction: (index) async {
        if (index == 0) {
          Navigate.back();
        }

        if (index == 1) {
          loadModal();
          await authApp.clearSession();
          Get.offAllNamed(Screen.SPLASH_PAGE_ROUTE);
        }
      },
    );
  }
}
